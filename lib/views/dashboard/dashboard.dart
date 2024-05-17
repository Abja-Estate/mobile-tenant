import 'dart:convert';
import 'package:abjatenant/network/request.dart';
import 'package:abjatenant/provider/property_provider.dart';
import 'package:abjatenant/provider/request_provider.dart';
import 'package:abjatenant/provider/user_provider.dart';
import 'package:abjatenant/utils/property_util/access_code_utils.dart';
import 'package:abjatenant/views/dashboard/widgets/service_agents_row.dart';
import 'package:abjatenant/views/request/request.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';

import '../../provider/websocket_provider.dart';
import '../../utils/app_utils.dart';
import '../navbar/nav.dart';
import 'widgets/bottomsheet.dart';
import 'widgets/request_tab.dart';
import 'widgets/unit_content.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late WebSocketProvider webSocketProvider;
  late RequestProvider requestProvider;
  late UserProvider userProvider;

  var photo = 'https://picsum.photos/200';

  String searchItem = '';

  var name = "";
  var fullAddress = 'fetching your location ...';
  var code = '';

  _runFilter(value) {
    setState(() {
      searchItem = value;
    });
  }

  getins() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getins();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AccessCodeUtil.isDeleted(context);
      Provider.of<RequestProvider>(context, listen: false).getAllRequest();
      Provider.of<UserProvider>(context, listen: false).getItems();
      Provider.of<PropertyProvider>(context, listen: false).validateAccount();
      Provider.of<WebSocketProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));

    final _getSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: _getSize.width,
            height: _getSize.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Consumer2<UserProvider, PropertyProvider>(builder:
                              (context, userProvider, propertyProvider, child) {
                            name = userProvider.name;
                            photo = userProvider.photo;
                            var isRefresh = propertyProvider.refresh;
                            if (isRefresh) {
                              Future.delayed(Duration(seconds: 3), () {
                                // setState to trigger a rebuild after the delay
                                setState(() {
                                  // Change state here
                                });
                              });
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Hello ',
                                                style: AppFonts.bodyText
                                                    .copyWith(
                                                        color: Pallete
                                                            .primaryColor,
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                name,
                                                style: AppFonts.bodyText
                                                    .copyWith(
                                                        color: Pallete
                                                            .primaryColor,
                                                        fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          Navigator.of(context)
                                              .pushNamed(AppRoutes.profile);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ClipOval(
                                            child: Image.network(
                                              photo,
                                              fit: BoxFit.cover,
                                              width: 56,
                                              height: 56,
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: _getSize.width * 0.005,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                            backgroundColor:
                                                Pallete.backgroundColor,
                                            context: context,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            builder: (BuildContext context) {
                                              return AccountsBottomSheet();
                                            },
                                          );
                                        },
                                        child: ClipOval(
                                          child: Container(
                                            color: Pallete.hintColor,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/icons/switch.png",
                                                width: 15,
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            );
                          }),
                         
                      ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Rented Unit',
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.018,
                            fontWeight: FontWeight.w300,
                            color: Pallete.text),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      DashboardUnitContent(
                        getSizeWidth: _getSize.width,
                        getSizeHeight: _getSize.height,
                      ),
                      Text(
                        'Make A Request',
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.018,
                            fontWeight: FontWeight.w300,
                            color: Pallete.text),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      ServiceProviderRow(getSize: _getSize),
                      SizedBox(
                        height: _getSize.height * 0.035,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Request',
                            style: AppFonts.boldText.copyWith(
                                fontSize: _getSize.height * 0.018,
                                fontWeight: FontWeight.w300,
                                color: Pallete.text),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavBar(
                                          initialScreen: RequestScreen(),
                                          initialTab: 1,
                                        )),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'View All',
                              style: AppFonts.boldText.copyWith(
                                  fontSize: _getSize.height * 0.015,
                                  fontWeight: FontWeight.w300,
                                  color: Pallete.text),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      DashboardRequestMenu(
                        getSizeWidth: _getSize.width,
                        getSizeHeight: _getSize.height,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
