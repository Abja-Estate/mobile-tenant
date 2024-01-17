import 'dart:convert';

import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/components/input_field.dart';
import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../../constants/app_images.dart';
import '../../../provider/websocket_provider.dart';
import '../../../utils/local_storage.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key}) : super(key: key);

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  late WebSocketProvider webSocketProvider;


  List<Map<String, dynamic>> priority = [
    {
      "type": "High Priority",
      'color': Color(0xFFEB5757),
      'color2': Color(0xFFFCE6E6)
    },
    {
      "type": "Medium Priority",
      'color': Color(0xFFF2994A),
      'color2': Color.fromARGB(255, 255, 242, 231),
    },
    {
      "type": "Low Priority",
      'color': Color(0xFFF2C94C),
      'color2': Color.fromARGB(255, 255, 247, 222),
    },
    {
      "type": "None",
      'color': Color(0xFF2D9CDB),
      'color2': Color.fromARGB(255, 228, 245, 255),
    },
  ];

  int selectedIndex = -1;
  bool isSelected = true;

  List<Map<String, String>> issues = [];
  List<bool> select = [];
  Map<String, dynamic> property = {};
  var landlordid = '';
  var unitID = '';
  getPropertyItems() async {
    var propertyString = await showUnitData();

    var getproperty = Map<String, dynamic>.from(jsonDecode(propertyString));
    if (getproperty.isEmpty) {
    } else {
      setState(() {
        property = getproperty;
        landlordid = property['data']['landlordID'];
        unitID = property['data']['unitID'];
        print(property);
      });
    }
  }

  @override
  void initState() {
    webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);

    getPropertyItems();
    super.initState();
    // Initialize your lists here
    issues = [
      {
        "problem":
            "Install, repair, and maintain electrical wiring and fixtures"
      },
      {"problem": "Troubleshoot electrical problems"},
      {"problem": "Upgrade electrical service"},
      {
        "problem":
            "Install safety devices, such as smoke detectors,  carbon monoxide detectors and smart home devices.",
      },
    ];

    select = List.generate(issues.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
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
                    Text("Make A Request"),
                    Text("")
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
                            physics: BouncingScrollPhysics(),
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
                                              issues[index]['problem']!,
                                              style: AppFonts.bodyText.copyWith(
                                                  color: Pallete.text),
                                            ),
                                          ),
                                          Checkbox(
                                            value: select[index],
                                            onChanged: (value) {
                                              setState(() {
                                                select[index] = value!;
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5), // Adjust the radius as needed
                                              side: BorderSide(
                                                color: Colors
                                                    .green, // Set the border color
                                                width:
                                                    0.5, // Set the border width
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
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 30,
                            childAspectRatio:
                                1, // This value needs to be adjusted
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
                                    selectedIndex =
                                        index; // Select the tapped item
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? priority[index]["color2"]
                                        : Pallete.whiteColor,
                                    border: Border.all(
                                        width: 0.3, color: Pallete.fade),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppImages.tag,
                                        width: 16,
                                        color: priority[index]["color"],
                                      ),
                                      SizedBox(
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
                      height: _getSize.height * 0.008,
                    ),
                    Text(
                      'Contact:',
                      style: AppFonts.boldText.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.02,
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
                        SizedBox(
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
                          onPressed: () {
                            Map<String, dynamic> data = {
                              "target_id": landlordid,
                              "message": "Sup,postman",
                              "sender_id": unitID
                            };
                            print(data);
                            webSocketProvider.sendMessage(jsonEncode(data));
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
