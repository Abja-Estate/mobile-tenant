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
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../constants/resources.dart';
import '../../models/tenanModel.dart';
import '../../network/property.dart';
import '../../provider/websocket_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';
import '../../utils/location.dart';
import '../../utils/permissions.dart';
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

  @override
  void initState() {
    super.initState();
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
          AccessCodeUtil.isDeleted(context);
      Provider.of<RequestProvider>(context, listen: false).getAllRequest();
      Provider.of<UserProvider>(context, listen: false).getItems();
  
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
                          Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                            name = userProvider.name;
                            photo = userProvider.photo;
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
                          SizedBox(
                            height: _getSize.height * 0.003,
                          ),
                          Container(
                            height: _getSize.height * 0.055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFF949494),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: TextField(
                                      onChanged: (value) => _runFilter(value),
                                      decoration: const InputDecoration(
                                        hintText: 'Search',
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          AppFonts.body1.copyWith(fontSize: 14),
                                      // Add any necessary event handlers for text changes or submission.
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (searchItem.isEmpty) {
                                      AppUtils.showSnackBarMessage(
                                          'Enter an item to search for',
                                          context);
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
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.search,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.024,
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
