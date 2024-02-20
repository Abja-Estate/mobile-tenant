import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../provider/user_provider.dart';
import '../dashboard/widgets/request_tab.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoaded = false;
  late UserProvider userProvider;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getAllHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    const Text("Notifications"),
                    const Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              SizedBox(
                height: _getSize.height * 0.9,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        height: _getSize.height * 0.03,
                        buttonMargin:
                            const EdgeInsets.symmetric(horizontal: 16),
                        borderWidth: 0.5,
                        borderColor: Pallete.primaryColor,
                        backgroundColor: Pallete.primaryColor,
                        unselectedBackgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "All",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Rent",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Request",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                        print(userProvider.fetchingHistory);
                        var requestHistory = filterNotifications(
                            userProvider.history, "request");
                        var rentHistory = filterRentNotifications(
                            userProvider.history, "rent");
                           List combinedList = rentHistory + requestHistory;
                        return !userProvider.fetchingHistory
                            ? Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                     bottom(getSize: _getSize,data: combinedList,),
                                    bottom(
                                      getSize: _getSize,
                                      data: rentHistory,
                                    ),
                                    bottom(
                                        getSize: _getSize,
                                        data: requestHistory),
                                  ],
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _getSize.height * 0.15,
                                      ),
                                      SpinKitRing(
                                        size: 40,
                                        lineWidth: 2.5,
                                        color: Pallete.primaryColor,
                                      ),
                                      Text("Loading")
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({super.key, required Size getSize, required this.data})
      : _getSize = getSize;

  final Size _getSize;
  final List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    var services = data;
    return services.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16),
            child: SizedBox(
                width: _getSize.width * 0.9,
                height: _getSize.height * 0.9,
                child: ListView.builder(
                    itemCount: services.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 8, right: 16, left: 16),
                        child: Container(
                          height: services[index]['data'].length == 1
                              ? _getSize.height * 0.12 // For length < 2
                              : services[index]['data'].length == 2
                                  ? _getSize.height * 0.17 // For length < 2
                                  : services[index]['data'].length == 3
                                      ? _getSize.height * 0.24 // For length < 2
                                      : services[index]['data'].length == 4
                                          ? _getSize.height * 0.3
                                          : _getSize.height * 0.3,
                          width: _getSize.width,
                          decoration: const BoxDecoration(
                              color: Pallete.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(44, 85, 80, 80),
                                  blurRadius: 11,
                                  spreadRadius: 1,
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  services[index]['time'],
                                  style: AppFonts.boldText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: services[index]['data'].length == 1
                                      ? _getSize.height * 0.06 // For length < 2
                                      : services[index]['data'].length == 2
                                          ? _getSize.height *
                                              0.11 // For length < 2
                                          : services[index]['data'].length == 3
                                              ? _getSize.height *
                                                  0.17 // For length < 3
                                              : services[index]['data']
                                                          .length ==
                                                      4
                                                  ? _getSize.height *
                                                      0.24 // For length < 4
                                                  : _getSize.height *
                                                      0.24, // For length >= 4
                                  child: buildListItem(
                                      context,
                                      services[index]['data'],
                                      _getSize.width,
                                      services[index]['type']),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          )
        : Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: _getSize.height * 0.15,
                  ),
                  Image.asset(AppImages.noNotification),
                  Text("You currently have no rentage notification")
                ],
              ),
            ),
          );
  }
}

Widget buildListItem(BuildContext context, List<Map<String, dynamic>> service,
    double getSizeWidth, serviceType) {
  // Assuming AppFonts and Pallete are defined elsewhere in your project.
  return ListView.builder(
      itemCount: service.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var show;
        if (serviceType == "request") {
          show = true;
        } else {
          show = false;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                service[index]['icon'],
                width: getSizeWidth * 0.065,
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: getSizeWidth * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible: !show,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:service[index]['status']=="Paid"? Color(0xFFC8DCC5):Color(0xFFBCE3DC),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color:service[index]['status']=="Paid"? Pallete.primaryColor:Color(0xFF21A18A),
                                        size: 4,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        service[index]['status'],
                                        style: AppFonts.body1.copyWith(
                                            color: service[index]['status']=="Paid"? Pallete.primaryColor:Color(0xFF21A18A),
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        !show
                            ? SizedBox(
                              width: getSizeWidth*0.445,
                              child: Text(
                                  service[index]['status'] != "Paid"
                                      ? "Your Rent will expires in ${service[index]['expires']} month, kindly pay your rent"
                                      : "Your Rent for ${service[index]['expires']} months has been paid!",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                  style: AppFonts.bodyText.copyWith(
                                      color: Pallete.text, fontSize: 12),
                                ),
                            )
                            : Text(
                                "Your Request for ${service[index]['agent']} is ",
                                style: AppFonts.bodyText.copyWith(
                                    color: Pallete.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                      ],
                    ),
                    const SizedBox(height: 8),
                    show
                        ? Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(
                                        service[index]['status'] == "Pending"
                                            ? 0xFFFBE1BA
                                            : 0xFFFB3D5EE),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Color(service[index]['status'] ==
                                                "Pending"
                                            ? 0xFFF29B18
                                            : 0xFF0174C7),
                                        size: 4,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        service[index]['status'],
                                        style: AppFonts.body1.copyWith(
                                            color: Color(service[index]
                                                        ['status'] ==
                                                    "Pending"
                                                ? 0xFFF29B18
                                                : 0xFF0174C7),
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              service[index]['status'] != "Pending"
                                  ? Text(
                                      "Your ${service[index]['agent']} is on the way",
                                      style: AppFonts.bodyText
                                          .copyWith(fontSize: 12))
                                  : const SizedBox()
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.more_vert),
            ],
          ),
        );
      });
}

filterNotifications(data, type) {
  // Filter the list to get all objects with type "request"
  List<Map<String, dynamic>> requestList =
      data.where((request) => request['type'] == type).toList();

  // Group the requests by time frame
  Map<String, List<Map<String, dynamic>>> groupedByTime =
      groupByTime(requestList);

  // Create the final result list
  List<Map<String, dynamic>> finalResult = [];

  // Convert groupedByTime to the desired data structure
  groupedByTime.forEach((timeFrame, requests) {
    List<Map<String, dynamic>> data = [];

    for (var request in requests) {
      data.add({
        'icon': getIconAssetName(request['data']['status']),
        ...request['data'],
      });
    }

    finalResult.add({
      'type': 'request',
      'time': timeFrame,
      'data': data,
    });
  });

  // Sort final result list by time frame
  finalResult.sort((a, b) {
    if (a['time'] == 'Today') {
      return -1; // Move 'Today' to the beginning
    } else if (b['time'] == 'Today') {
      return 1;
    } else {
      // Compare other time frames
      return a['time'].compareTo(b['time']);
    }
  });

  // Print the final result
  print(finalResult);
  return finalResult;
}

filterRentNotifications(data, type) {
  // Filter the list to get all objects with type "request"
  List<Map<String, dynamic>> requestList =
      data.where((request) => request['type'] == type).toList();

  // Group the requests by time frame
  Map<String, List<Map<String, dynamic>>> groupedByTime =
      groupByTime(requestList);

  // Create the final result list
  List<Map<String, dynamic>> finalResult = [];

  // Convert groupedByTime to the desired data structure
  groupedByTime.forEach((timeFrame, requests) {
    List<Map<String, dynamic>> data = [];

    for (var request in requests) {
      data.add({
        'icon': getIconAssetName(request['data']['status']),
        ...request['data'],
      });
    }

    finalResult.add({
      'type': 'rent',
      'time': timeFrame,
      'data': data,
    });
  });
  // Sort final result list by time frame
  finalResult.sort((a, b) {
    if (a['time'] == 'Today') {
      return -1; // Move 'Today' to the beginning
    } else if (b['time'] == 'Today') {
      return 1;
    } else {
      // Compare other time frames
      return a['time'].compareTo(b['time']);
    }
  });
  // Print the final result
  print(finalResult);
  return finalResult;
}

Map<String, List<Map<String, dynamic>>> groupByTime(
    List<Map<String, dynamic>> requestList) {
  Map<String, List<Map<String, dynamic>>> groupedByTime = {};

  for (var request in requestList) {
    DateTime requestTime = DateTime.parse(request['data']['time']);
    String timeFrame = getTimeFrame(requestTime);

    if (!groupedByTime.containsKey(timeFrame)) {
      groupedByTime[timeFrame] = [];
    }

    groupedByTime[timeFrame]?.add(request);
  }

  return groupedByTime;
}

String getTimeFrame(DateTime requestTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(requestTime);

  if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Tomorrow';
  } else if (difference.inDays <= 7) {
    return 'A Week Ago';
  } else if (difference.inDays <= 14) {
    return '2 Weeks Ago';
  } else if (difference.inDays <= 30) {
    return '1 Month Ago';
  } else if (difference.inDays <= 60) {
    return '2 Month Ago';
  } else {
    return 'Old Request';
  }
}
