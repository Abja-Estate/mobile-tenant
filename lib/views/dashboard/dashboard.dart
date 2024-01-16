import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../constants/resources.dart';
import '../../models/dashItem.dart';
import '../../models/pharm.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';
import '../../utils/location.dart';
import '../../utils/permissions.dart';

import '../drawer_menu/sidebar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CarouselController carouselController = CarouselController();
  int _sliderIndex = 0;

  final _sliderItemLength = DashItems.loadItems().length;
  final _sliderItem = DashItems.loadItems();
  // final Size = MediaQuery.of(context).size;
  var photo = 'https://picsum.photos/200';

  bool loaded = false;

  var _serviceEnabled;

  var _permissionGranted;

  var fullAddress = 'fetching your location ...';
  getData() async {
    email = await showEmail();
    var mlocate =
        await getAddress(getUserLocation(_serviceEnabled, _permissionGranted));
    print(mlocate['fullAddress'].toString());
    fullAddress = mlocate['fullAddress'].toString();
    await saveUserState(mlocate['state']);
    await saveCity(mlocate['city']);
    setState(() {
      email;
      fullAddress;
    });
  }

  String searchItem = '';

  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";
  getName() async {
    name = await showName();
    surname = await showSurname();
    photo = await showSelfie();
    if (photo == '') {
      photo = 'https://picsum.photos/200';
    } else {
      photo;
    }
    setState(() {
      photo;
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
    getName();
    getData();
    getPropertyItems();
    super.initState();
  }

  bool isLoadingProperty = true;
  Map<String, dynamic> property = {};
  getPropertyItems() async {
    isLoadingProperty = true;
    var propertyString = await showUnitData();

    var getproperty = Map<String, dynamic>.from(jsonDecode(propertyString));
    if (getproperty.isEmpty) {
    } else {
      setState(() {
        property = getproperty;

        isLoadingProperty = false;
      });
    }
  }

  var noRequest = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final _getSize = MediaQuery.of(context).size;
    final _sliderItemLength = DashItems.loadItems().length;
    final _sliderItem = DashItems.loadItems();
    final Size = MediaQuery.of(context).size;
    final walkThroughItem = PharmItems.loadItems();
    List<Widget> items = [];

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
                              GestureDetector(
                                  onTap: () {
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
                                  ))
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
                      property.isNotEmpty
                          ? properties(
                              getSizeWidth: _getSize.width,
                              getSizeHeight: _getSize.height,
                              unit: property,
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F9F5),
                                  borderRadius: BorderRadius.circular(10)),
                              width: _getSize.width,
                              height: _getSize.height * 0.25,
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
                                      "Loading your unit image",
                                      style: AppFonts.body1,
                                    ),
                                  ],
                                ),
                              ),
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
                      middle(getSize: _getSize),
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
                      noRequest
                          ? bottom(
                              getSizeWidth: _getSize.width,
                              getSizeHeight: _getSize.height,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: _getSize.height * 0.2,
                                width: _getSize.width,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(44, 85, 80, 80),
                                        blurRadius: 11,
                                        spreadRadius: 1,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.noRequest,
                                      width: _getSize.width * 0.6,
                                    ),
                                    Text(
                                        'You currently have no Request at this time...')
                                  ],
                                ),
                              ),
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

class properties extends StatelessWidget {
  const properties(
      {super.key,
      required this.getSizeWidth,
      required this.getSizeHeight,
      required this.unit});

  final double getSizeHeight;
  final double getSizeWidth;
  final Map<String, dynamic> unit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: getSizeWidth,
        height: getSizeHeight * 0.45,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(AppRoutes.propDetails);
          },
          child: Column(
            children: [
              Image.network(
                unit["data"]["photo"],
                fit: BoxFit.cover,
                width: getSizeWidth,
                height: getSizeHeight * 0.25,
              ),
              SizedBox(
                height: getSizeHeight * 0.01,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit["propertyName"],
                        style: AppFonts.boldText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 79, 88, 106)),
                      ),
                      SizedBox(
                        height: getSizeHeight * 0.005,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.estate,
                                width: 20,
                              ),
                              SizedBox(
                                width: getSizeWidth * 0.008,
                              ),
                              Text(
                                unit["propertyStructure"],
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade, fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.06,
                          ),
                          Row(
                            children: [
                              Image.asset(AppImages.location, width: 14),
                              SizedBox(
                                width: getSizeWidth * 0.008,
                              ),
                              SizedBox(
                                width: getSizeWidth * 0.5,
                                child: Text(
                                  unit["location"],
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.fade, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getSizeHeight * 0.02,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.bedroom,
                            width: 24,
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.01,
                          ),
                          Text(
                            unit["data"]["bedroom"],
                          )
                        ],
                      ),
                      SizedBox(
                        height: getSizeHeight * 0.001,
                      ),
                      Text(
                        "Bedroom",
                        style: AppFonts.bodyText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    width: getSizeWidth * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.toilet,
                            width: 24,
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.01,
                          ),
                          Text(unit["data"]["toilet"])
                        ],
                      ),
                      SizedBox(
                        height: getSizeHeight * 0.001,
                      ),
                      Text(
                        "Toilet",
                        style: AppFonts.bodyText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    width: getSizeWidth * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.bathroom,
                            width: 24,
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.01,
                          ),
                          Text(unit["data"]["bathroom"])
                        ],
                      ),
                      SizedBox(
                        height: getSizeHeight * 0.001,
                      ),
                      Text(
                        "Bathroom",
                        style: AppFonts.bodyText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    width: getSizeWidth * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.nepa,
                            width: 24,
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.01,
                          ),
                          Text(unit["data"]["waterMeter"])
                        ],
                      ),
                      SizedBox(
                        height: getSizeHeight * 0.001,
                      ),
                      Text(
                        "Water Meter",
                        style: AppFonts.bodyText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getSizeHeight * 0.01,
              ),
              Row(
                children: [
                  unit["data"]["wifi"]
                      ? Row(
                          children: [
                            Image.asset(
                              AppImages.wifi,
                              width: 20,
                            ),
                            SizedBox(
                              width: getSizeWidth * 0.015,
                            ),
                            Text(
                              "Wifi",
                              style: AppFonts.body1,
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(
                    width: getSizeWidth * 0.05,
                  ),
                  unit["data"]["power"]
                      ? Row(
                          children: [
                            Image.asset(
                              AppImages.power,
                              width: 24,
                            ),
                            SizedBox(
                              width: getSizeWidth * 0.005,
                            ),
                            Text(
                              "24hrs Power",
                              style: AppFonts.body1,
                            ),
                            SizedBox(
                              width: getSizeWidth * 0.05,
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.nepa,
                        width: 24,
                      ),
                      SizedBox(
                        width: getSizeWidth * 0.005,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unit["data"]["lightMeter"],
                          ),
                          Text(
                            "Light Meter",
                            style: AppFonts.body1,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class middle extends StatelessWidget {
  const middle({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width,
        height: _getSize.height * 0.1,
        child: ListView.builder(
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.taskScreen,
                    arguments: {
                      'request': services[index]['text'],
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 8, left: 4),
                  child: Container(
                    height: _getSize.height * 0.001,
                    width: _getSize.width * 0.23,
                    decoration: BoxDecoration(
                        color: services[index]['color'],
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(44, 85, 80, 80),
                            blurRadius: 11,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          services[index]['icon'],
                          width: _getSize.width * 0.06,
                          color: services[index]['color2'],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          services[index]['text'],
                          style: AppFonts.body1.copyWith(
                              color: Pallete.fade,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class bottom extends StatelessWidget {
  const bottom({
    super.key,
    required this.getSizeWidth,
    required this.getSizeHeight,
  });

  final double getSizeHeight;
  final double getSizeWidth;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {'icon': AppImages.agent, 'color': Color(0xFFDAE7D9), 'text': 'Agent'},
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFFCEADA),
        'text': 'Electrician'
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFEADAFF),
        'text': 'Plumber'
      },
      {
        'icon': AppImages.funmigate,
        'color': Color(0xFFFFE4E9),
        'text': 'Fumigator'
      },
    ];
    return SizedBox(
        width: getSizeWidth,
        height: getSizeHeight * 0.38,
        child: ListView.builder(
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 8, left: 4),
                child: Container(
                  height: getSizeHeight * 0.07,
                  width: getSizeWidth,
                  decoration: BoxDecoration(
                      color: services[index]['color'],
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
                          services[index]['icon'],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: getSizeWidth * 0.71,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    services[index]['text'],
                                    style: AppFonts.body1.copyWith(
                                        color: Pallete.text,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "2 hours ago",
                                    style: AppFonts.body1.copyWith(
                                        color: Pallete.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getSizeHeight * 0.007,
                            ),
                            SizedBox(
                              width: getSizeWidth * 0.6,
                              child: Text(
                                'I need an electrician to install a new light fixture in my living room. The light fixture is a chandelier and it will need to be wired into the existing electrical system.',
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
              );
            }));
  }
}
