import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/views/dashboard/widgets/request_tab.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/buttons.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/request_provider.dart';
import '../../utils/app_utils.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late RequestProvider requestProvider;
  int _tabIndex = 0;
  bool loaded = false;
  List request = [];

  @override
  void initState() {
    loaded = true;
    request;

    Provider.of<RequestProvider>(context, listen: false).getAllRequest();
    super.initState();
  }

  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(""),
                  Text("Request"),
                  Icon(Icons.filter_list)
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.035,
              ),
              Container(
                height: _getSize.height * 0.055,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Color(0xFF949494),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                          style: AppFonts.body1.copyWith(fontSize: 14),
                          // Add any necessary event handlers for text changes or submission.
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var searchItem;
                        if (searchItem.isEmpty) {
                          AppUtils.showSnackBarMessage(
                              'Enter an item to search for', context);
                        } else {
                          Navigator.of(context).pushNamed(
                            AppRoutes.randomSearch,
                            arguments: {
                              'search': searchItem,
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              SizedBox(
                height: _getSize.height * 0.76,
                child: Stack(children: [
                  Consumer<RequestProvider>(
                      builder: (context, requestProvider, child) {
                    var requestData = requestProvider.request;

                    var pendingRq = filterRequest(requestData, false);
                    var acceptedRq = filterRequest(requestData, true);
                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabNavBar(
                            tabIndex: _tabIndex,
                            tabTextList: [
                              'Pending (${pendingRq.length})',
                              'Accepted (${acceptedRq.length})',
                            ],
                            onTap: (index) {
                              setState(() {
                                _tabIndex = index;
                              });
                            },
                          ),
                          !loaded
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F9F5),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: _getSize.width,
                                  height: _getSize.height * 0.38,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SpinKitRing(
                                          size: 30,
                                          color: Pallete.primaryColor,
                                          lineWidth: 2.0,
                                        ),
                                        Text(
                                          "Looking for your request Listing",
                                          style: AppFonts.body1,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    requestData.isEmpty
                                        ? Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF6F9F5),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: _getSize.width,
                                            height: _getSize.height * 0.38,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.asset(
                                                    AppImages.no_prop,
                                                    width: _getSize.width * 0.6,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "You currently have no accepted/pending request",
                                                        style: AppFonts.body1,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        _getSize.height * 0.01,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) // Widget to show when many is 0
                                        : SizedBox(
                                            height: _getSize.height * 0.6795,
                                            child: TabBarView(
                                              // physics: const NeverScrollableScrollPhysics(),
                                              children: <Widget>[
                                                tabContent(
                                                  requestData: pendingRq,
                                                  getSize: _getSize,
                                                  items: pendingRq.length,
                                                ),
                                                tabAcceptedContent(
                                                  requestData: acceptedRq,
                                                  getSize: _getSize,
                                                  items: acceptedRq.length,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                )
                        ],
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 60,
                    child: ButtonWithFuction(
                        text: 'Make A Request',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.createRequest);
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class tabContent extends StatelessWidget {
  tabContent(
      {super.key,
      required Size getSize,
      required this.items,
      required this.requestData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  List requestData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.25,
        child: ListView.builder(
            itemCount: requestData.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DateTime dateTime = DateTime.parse(requestData[index]['time']);
              String formattedTimeDifference = formatTimeDifference(dateTime);

              return GestureDetector(
                onTap: (){
                     Navigator.of(context).pushNamed(AppRoutes.viewRequest,
                      arguments: {"data": requestData[index]});
                },
                child:
                 Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 8, left: 4),
                  child: Container(
                    height: _getSize.height * 0.07,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: getIconAssetColor(requestData[index]['agent']),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(44, 85, 80, 80),
                            blurRadius: 11,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            getIconAssetName(requestData[index]['agent']),
                            width: _getSize.width * 0.065,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _getSize.width * 0.71,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      requestData[index]['agent'],
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      formattedTimeDifference,
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.007,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.6,
                                child: Text(
                                  requestData[index]['description'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.fade,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

class tabAcceptedContent extends StatelessWidget {
  tabAcceptedContent(
      {super.key,
      required Size getSize,
      required this.items,
      required this.requestData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  List requestData;

  /**
   *     PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MainScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
   */

  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.25,
        child: ListView.builder(
            itemCount: requestData.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DateTime dateTime = DateTime.parse(requestData[index]['time']);
              String formattedTimeDifference = formatTimeDifference(dateTime);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.viewRequest,
                      arguments: {"data": requestData[index]});
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 8, left: 4),
                  child: Container(
                    height: _getSize.height * 0.088,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: getIconAssetColor(requestData[index]['agent']),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(44, 85, 80, 80),
                            blurRadius: 11,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              photo,
                              fit: BoxFit.cover,
                              width: 52,
                              height: 52,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.67,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Text(
                                      requestData[index]['agentName'] ??
                                          "-- --",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          getIconAssetName(
                                              requestData[index]['agent']),
                                          width: _getSize.width * 0.045,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          requestData[index]['agent'],
                                          style: AppFonts.body1.copyWith(
                                              color: Pallete.fade,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.4,
                                      child: Text(
                                        requestData[index]['description'],
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.fade,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.01,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: _getSize.height * 0.01,
                                    ),
                                    Text(
                                      formattedTimeDifference,
                                      style: AppFonts.body1.copyWith(
                                        color: Pallete.primaryColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.007,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

_runFilter(String value) {}

class TabNavBar extends StatefulWidget {
  const TabNavBar({
    Key? key,
    required this.tabIndex,
    required this.tabTextList,
    required this.onTap,
  }) : super(key: key);

  final int tabIndex;
  final List<String> tabTextList;
  final Function(int)? onTap;

  @override
  _TabNavBarState createState() => _TabNavBarState();
}

class _TabNavBarState extends State<TabNavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: BoxDecoration(
        color: Pallete.backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        onTap: widget.onTap,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Pallete.fade,
        indicator: BoxDecoration(
          color: Pallete.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        tabs: widget.tabTextList
            .map((tabText) => TabBarItem(
                  text: tabText,
                  count: widget.tabTextList.length,
                ))
            .toList(),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.count,
    required this.text,
  }) : super(key: key);

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: count == 5 ? 9 : 12,
          ),
        ),
      ),
    );
  }
}

filterRequest(data, isApprove) {
  List<Map<String, dynamic>> filteredData =
      data.where((obj) => obj['isLandlordApproved'] == isApprove).toList();
  return filteredData;
}

String formatTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  print(difference.inHours);
  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
  } else {
    return 'Just now';
  }
}
