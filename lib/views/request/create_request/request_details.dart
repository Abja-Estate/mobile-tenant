import 'dart:convert';
import 'package:abjatenant/utils/app_utils.dart';
import 'package:abjatenant/utils/bottom_modal.dart';
import 'package:abjatenant/views/notification/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/components/input_field.dart';
import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/resources.dart';
import '../../../provider/websocket_provider.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/notification_util.dart';
import '../../navbar/nav.dart';
import '../request.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key}) : super(key: key);

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  late WebSocketProvider webSocketProvider;
  bool wssResult = false;
  bool isSlotAPicked = false;
  bool isSlotBPicked = false;
  int selectedIndex = -1;
  int selectedTimeSlotIndexTo = -1;
  int selectedTimeSlotIndexFrom = -1;
  bool isSelected = true;
  var periodA = "";
  var periodB = "";
  List issues = [];
  List<String> timeSlot = [];
  List<bool> select = [];
  Map<String, dynamic> mUnit = {};
  Map<String, dynamic> property = {};
  Map<String, dynamic> requestData = {
    "agent": "",
    "description": "",
    "priority": "",
    "phone": "",
    "email": "",
    "tenantPhoto": "",
    "propertyLocation": "",
    "problems": []
  };
  var landlordID = '';
  var unitID = '';

  bool startOver = false;
  getPropertyItems() async {
    var unitString = await showUnitData();
    var propertyString = await showPropertyData();
    unitID = await showuuId();
    var getUnit = Map<String, dynamic>.from(jsonDecode(unitString));
    var getProperty = Map<String, dynamic>.from(jsonDecode(propertyString));
    setState(() {
      mUnit = getUnit;
      property = getProperty;

      landlordID = mUnit['landlordID'];
      select = List.generate(issues.length, (index) => false);
    });
  }

  DateTime startDate = DateTime.now();
  String startholderDate = 'dd/mm/yyyy';
  String endholderDate = 'dd/mm/yyyy';
  DateTime endDate = DateTime.now().add(Duration(days: 180)); // 6 months later
  bool haveSelectedStartDate = false;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        endDate = picked.add(Duration(days: 180));
        startholderDate = formatDate(startDate);
        // Update end date to be at least 6 months later
        haveSelectedStartDate = true;
      });
    }
  }

  var problemsArray = [];
  @override
  void initState() {
    webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);

    getPropertyItems();
    super.initState();
    // Initialize your lists here
    issues = [];

    timeSlot = [
      "8:45 AM",
      "9:30 AM",
      "10:15 AM",
      "12:45 PM",
      "1:45 PM",
      "2:45 PM",
      "3:45 PM",
      "4:30 PM",
      "5:00 PM"
    ];
     
  }

  bool isDataEmpty(Map<String, dynamic> data) {
    for (var entry in data.entries) {
      if (entry.value == null ||
          (entry.value is String && entry.value.isEmpty) ||
          (entry.value is String && entry.value == 'dd/mm/yyyy') ||
          (entry.value is String && entry.value == ' - ') ||
          (entry.value is Iterable && (entry.value as Iterable).isEmpty) ||
          (entry.value is Map && (entry.value as Map).isEmpty) ||
          (entry.value is int && entry.value == 0)) {
        return true; // Return true if any value is empty, null, or an empty collection
      }
    }
    return false; // Return false if all values are non-empty
  }

  var agent = '';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    agent = dataFromRoute["agent"];
    issues = dataFromRoute["job"];
   
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    AppImages.back,
                    width: 36,
                  ),
                ),
                Text("Make A Request For $agent"),
                const Text("")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: _getSize.width,
                    height: _getSize.height * 0.35,
                    child: ListView.builder(
                        itemCount: issues.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Pallete.whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: _getSize.width * 0.7,
                                        child: Text(
                                          issues[index]!,
                                          style: AppFonts.bodyText
                                              .copyWith(color: Pallete.text),
                                        ),
                                      ),
                                      Checkbox(
                                        value: select[index],
                                        onChanged: (value) {
                                          print(select[index]);
                                          select[index] = value ??
                                              true; // Update the select list
                                          if (select[index]) {
                                            problemsArray.add(issues[
                                                index]); // Item selected, add it
                                            print("Added: ${issues[index]}");
                                          } else {
                                            problemsArray.remove(issues[
                                                index]); // Item deselected, remove it
                                            print("Removed: ${issues[index]}");
                                          }
                                          setState(() {});
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Adjust the radius as needed
                                          side: const BorderSide(
                                            color: Colors
                                                .green, // Set the border color
                                            width: 0.5, // Set the border width
                                          ),
                                        ),

                                        activeColor: Colors
                                            .green, // Set the checkbox color
                                        checkColor: Colors
                                            .white, // Set the checkmark color
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                CustomInput3(
                  onSaved: (v) {},
                  onChanged: (v) {
                    requestData['others'] = v;
                  },
                  hint: 'Others',
                  label: 'Others',
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Text(
                  'Request Description:',
                  style: AppFonts.boldText.copyWith(fontSize: 14),
                ),
                CustomInput3(
                  onChanged: (p) {
                    requestData['description'] = p;
                  },
                  onSaved: (v) {},
                  hint: 'Request Description',
                  label: 'Request Description',
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Text(
                  'Priority:',
                  style: AppFonts.boldText.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: _getSize.height * 0.001,
                ),
                SizedBox(
                  height: _getSize.height * 0.12,
                  width: _getSize.width * 0.6,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 30,
                        childAspectRatio: 1, // This value needs to be adjusted
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: priority.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle the selected index
                              if (selectedIndex == index) {
                                selectedIndex = -1; // Clear selection
                              } else {
                                selectedIndex = index; // Select the tapped item
                                requestData['priority'] =
                                    priority[index]['type'];
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? priority[index]["color2"]
                                    : Pallete.whiteColor,
                                border:
                                    Border.all(width: 0.3, color: Pallete.fade),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppImages.tag,
                                    width: 16,
                                    color: priority[index]["color"],
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    priority[index]["type"],
                                    style: AppFonts.bodyText.copyWith(
                                        fontSize: 10,
                                        color: priority[index]["color"]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Text(
                  'Starting Date:',
                  style: AppFonts.boldText.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: _getSize.height * 0.008,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    suffixIconConstraints: BoxConstraints(minWidth: 35),
                    suffixIcon: Image.asset(
                      "assets/icons/calenda.png",
                      height: _getSize.height * 0.02,
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectStartDate(context),
                  controller: TextEditingController(text: startholderDate),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Text(
                  'Time Slot:',
                  style: AppFonts.boldText.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: _getSize.height * 0.01,
                ),
                Visibility(
                  visible: !startOver,
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From:',
                          style: AppFonts.boldText.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.14,
                          width: _getSize.width,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisExtent: 50,
                                childAspectRatio:
                                    2, // This value needs to be adjusted
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: timeSlot.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the selected index
                                      if (selectedTimeSlotIndexFrom == index) {
                                        selectedTimeSlotIndexFrom =
                                            -1; // Clear selection
                                      } else {
                                        isSlotAPicked = true;
                                        selectedTimeSlotIndexFrom =
                                            index; // Select the tapped item
                                        periodA = timeSlot[index];
                                      }
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            selectedTimeSlotIndexFrom == index
                                                ? Pallete.primaryColor
                                                : Pallete.whiteColor,
                                        border: Border.all(
                                            width: 0.3, color: Pallete.fade),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        timeSlot[index],
                                        style: AppFonts.bodyText.copyWith(
                                          color:
                                              selectedTimeSlotIndexFrom == index
                                                  ? Pallete.whiteColor
                                                  : Pallete.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isSlotAPicked,
                      child: Container(
                        height: _getSize.height * 0.147,
                        color: Color.fromARGB(166, 239, 239, 239),
                        width: _getSize.width,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: _getSize.height * 0.01,
                ),
                Visibility(
                  visible: !startOver,
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To:',
                          style: AppFonts.boldText.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.14,
                          width: _getSize.width,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisExtent: 50,
                                childAspectRatio:
                                    2, // This value needs to be adjusted
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: timeSlot.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the selected index
                                      if (selectedTimeSlotIndexTo == index) {
                                        selectedTimeSlotIndexTo =
                                            -1; // Clear selection
                                      } else {
                                        // print(selectedTimeSlotIndexFrom);

                                        periodB = timeSlot[index];
                                        if (isSlotAPicked == true &&
                                            selectedTimeSlotIndexFrom < index) {
                                          print(selectedTimeSlotIndexFrom);

                                          print(selectedTimeSlotIndexFrom);

                                          isSlotBPicked = true;
                                          selectedTimeSlotIndexTo =
                                              index; // Select the tapped item
                                          periodB = timeSlot[index];
                                          startOver = true;
                                        } else {
                                          if (isSlotAPicked) {
                                            AppUtils.ErrorDialog(
                                              context,
                                              'Error',
                                              "Pick a time earlier than $periodA if you want the work to end at $periodB",
                                              'Close',
                                              Icon(
                                                Icons.error_rounded,
                                                color: Color.fromARGB(
                                                    255, 213, 10, 10),
                                                size: 30,
                                              ),
                                            );
                                          } else {
                                            AppUtils.ErrorDialog(
                                              context,
                                              'Error',
                                              "Select the starting time first",
                                              'Close',
                                              Icon(
                                                Icons.error_rounded,
                                                color: Color.fromARGB(
                                                    255, 213, 10, 10),
                                                size: 30,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: selectedTimeSlotIndexTo == index
                                            ? Pallete.primaryColor
                                            : Pallete.whiteColor,
                                        border: Border.all(
                                            width: 0.3, color: Pallete.fade),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        timeSlot[index],
                                        style: AppFonts.bodyText.copyWith(
                                          color:
                                              selectedTimeSlotIndexTo == index
                                                  ? Pallete.whiteColor
                                                  : Pallete.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isSlotBPicked,
                      child: Container(
                        height: _getSize.height * 0.147,
                        color: Color.fromARGB(166, 239, 239, 239),
                        width: _getSize.width,
                      ),
                    ),
                  ]),
                ),
                Visibility(
                  visible: startOver,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Pallete.whiteColor,
                        border: Border.all(width: 0.3, color: Pallete.fade),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Pallete.whiteColor,
                                    border: Border.all(
                                        width: 0.3, color: Pallete.fade),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(periodA),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    color: Pallete.primaryColorVariant,
                                    width: _getSize.width * 0.2,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  ClipOval(
                                      child: Container(
                                    color: Pallete.primaryColorVariant,
                                    width: _getSize.width * 0.01,
                                    height: 4,
                                  ))
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Pallete.whiteColor,
                                    border: Border.all(
                                        width: 0.3, color: Pallete.fade),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(periodB),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              startOver = false;
                              isSlotAPicked = false;
                              isSlotBPicked = false;
                              setState(() {});
                            },
                            child: Text(
                              "View All Slots",
                              style: AppFonts.boldText.copyWith(
                                  color: Pallete.primaryColorVariant,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Text(
                  'Contact:',
                  style: AppFonts.boldText.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Pallete.primaryColor,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Phone Number',
                      style: AppFonts.bodyText,
                    )
                  ],
                ),
                CustomInput3(
                  onSaved: (v) {},
                  onChanged: (p) {
                    requestData['phone'] = p;
                  },
                  hint: 'Phone',
                  type: 'number',
                  label: 'Phone Number',
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.inbox_rounded,
                      color: Pallete.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Email Address',
                      style: AppFonts.bodyText,
                    )
                  ],
                ),
                CustomInput3(
                  onSaved: (v) {},
                  onChanged: (p) {
                    requestData['email'] = p;
                  },
                  hint: 'Email',
                  label: 'Email',
                ),
                SizedBox(
                  height: _getSize.height * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWithFuction(
                      text: 'Submit',
                      onPressed: () async {
                        await saveToken(false);
                        var dt = DateTime.now();
                        requestData['agent'] = agent;
                        requestData['problems'] = problemsArray;
                        requestData["tenantUnit"] = unitID;
                        requestData["time"] = dt.toString();
                        requestData['fullName'] =
                            '${mUnit['tenantInfo']['name']} ${mUnit['tenantInfo']['surname']}';
                        requestData["tenantPhoto"] =
                            mUnit['tenantInfo']['selfie'];
                        requestData["from"] = "tenant";
                        requestData["propertyLocation"] = property["location"];
                        requestData["propertyName"] = property["propertyName"];
                        requestData["landlordID"] = landlordID;
                        requestData["propertyStructure"] =
                            property["propertyStructure"];
                        requestData["period"] = "$periodA - $periodB";
                        requestData["day"] = startholderDate;

                        setState(() {});
                        Map<String, dynamic> data = {
                          "target_id": landlordID,
                          "message": jsonEncode(requestData),
                          "sender_id": unitID
                        };
                        print(data);

// Example usage:
                        if (isDataEmpty(requestData)) {
                       AppUtils.ErrorDialog(
                              context,
                              'Some fields are empty',
                              "You need to fill all the fields",
                              'Try Again',
                              Icon(
                                Icons.error_rounded,
                                color: Color.fromARGB(255, 213, 10, 10),
                                size: 30,
                              ),
                            );
                        } else {
                          AppUtils.showLoader(context);
                          webSocketProvider.sendMessage(jsonEncode(data));
                          await Future.delayed(Duration(seconds: 2));
                          var m = await showToken();
                          setState(() {});
                          print(m);
                          Navigator.of(context).pop();
                          if (m) {
                            showModalBottomSheet(
                              context: context,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (BuildContext context) {
                                return ReusableBottomSheetContent();
                              },
                            ).then((value) {
                              // This block will be executed when the bottom sheet is dismissed
                              if (value == null) {
                                // User dismissed the bottom sheet by clicking outside

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavBar(
                                            initialScreen: RequestScreen(),
                                            initialTab: 1,
                                          )),
                                  (route) => false,
                                );
                              }
                            });
                          } else {
                            AppUtils.ErrorDialog(
                              context,
                              'Request Failed',
                              "Your request failed to deliver",
                              'Try Again',
                              Icon(
                                Icons.error_rounded,
                                color: Color.fromARGB(255, 213, 10, 10),
                                size: 30,
                              ),
                            );
                          }
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}

// Create a new method to format the date
String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM yyyy');
  return formatter.format(date);
}

void showCustomDialog(BuildContext context, String message, timeSlot,
    selectedTimeSlotIndexFrom, _getSize) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext cxt) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Material(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From:',
                              style: AppFonts.boldText.copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              height: _getSize.height * 0.14,
                              width: _getSize.width,
                              child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    mainAxisExtent: 50,
                                    childAspectRatio:
                                        2, // This value needs to be adjusted
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemCount: timeSlot.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Toggle the selected index
                                        if (selectedTimeSlotIndexFrom ==
                                            index) {
                                          selectedTimeSlotIndexFrom =
                                              -1; // Clear selection
                                        } else {
                                          selectedTimeSlotIndexFrom =
                                              index; // Select the tapped item
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: selectedTimeSlotIndexFrom ==
                                                    index
                                                ? Pallete.primaryColor
                                                : Pallete.whiteColor,
                                            border: Border.all(
                                                width: 0.3,
                                                color: Pallete.fade),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            timeSlot[index],
                                            style: AppFonts.bodyText.copyWith(
                                              color:
                                                  selectedTimeSlotIndexFrom ==
                                                          index
                                                      ? Pallete.whiteColor
                                                      : Pallete.primaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
