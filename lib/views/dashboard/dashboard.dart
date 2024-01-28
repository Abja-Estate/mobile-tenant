import 'dart:convert';
import 'package:abjatenant/network/request.dart';
import 'package:abjatenant/provider/property_provider.dart';
import 'package:abjatenant/provider/request_provider.dart';
import 'package:abjatenant/views/dashboard/widgets/service_agents_row.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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

  // final Size = MediaQuery.of(context).size;
  var photo = 'https://picsum.photos/200';
  bool loaded = false;
  var _serviceEnabled;
  String searchItem = '';
  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";
  var _permissionGranted;
  var fullAddress = 'fetching your location ...';
  var code = '';

  getData() async {
    email = await showEmail();
    name = await showName();
    surname = await showSurname();
    photo = await showSelfie();
    code = await showAccessCode();
    var mlocate =
        await getAddress(getUserLocation(_serviceEnabled, _permissionGranted));
    print(mlocate['fullAddress'].toString());
    fullAddress = mlocate['fullAddress'].toString();
    await saveUserState(mlocate['state']);
    await saveCity(mlocate['city']);
    setState(() {
      email;
      fullAddress;
      fullname = "$name $surname";
    });
  }

  _runFilter(value) {
    setState(() {
      searchItem = value;
    });
  }

  @override
  void initState() {
    webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
    requestProvider = Provider.of<RequestProvider>(context, listen: false);
    getData();
    super.initState();
  }

  // getPropertiesData() async {
  //   var res = await PropertyAPI.accessCode(code);
  //   var codeInfo = res['statusCode'];
  //   if (codeInfo != 200) {}
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));

    final _getSize = MediaQuery.of(context).size;

    // webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
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
                          Row(
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
                                              style: AppFonts.bodyText.copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              name,
                                              style: AppFonts.bodyText.copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.location,
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              fullAddress,
                                              style: AppFonts.bodyThinColoured
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: Pallete.black),
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
                          ),
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
                          Text(
                            'View All',
                            style: AppFonts.boldText.copyWith(
                                fontSize: _getSize.height * 0.015,
                                fontWeight: FontWeight.w300,
                                color: Pallete.text),
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
