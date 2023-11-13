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

  static const alarmValueKey = ValueKey('Alarm');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<Key> valueNotifier = ValueNotifier<Key>(alarmValueKey);
  void toggleDrawer() {
    setState(() {
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openEndDrawer();
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    });
  }

  List<Map> ListItem = [
    {'image': "assets/images/icons/pills.png", 'text': 'Get medications.'},
    {
      'image': "assets/images/icons/textrack.png",
      'text': 'Order for a lab test'
    },
    {'image': "assets/images/icons/upload.png", 'text': 'Upload Prescription'},
    {
      'image': "assets/images/images/support_doc.jpeg",
      'text': 'Ask Pharm Josy'
    },
  ];
  List<Map> med = [
    {
      'image': "assets/images/images/pharmplug_icon_row3.png",
      'header': "Instant Home Deliveries",
      'text': 'Enjoy Home deliveries on products and prescriptions '
    },
    {
      'image': "assets/images/images/pharmplug_icon_row4.png",
      'header': "24/7 Customer support",
      'text': "Call, chat or reach a pharmacist anytime anyday"
    },
    {
      'image': "assets/images/images/pharmplug_icon_row1.png",
      'header': "PharmPlug Special",
      'text': 'Special programs and services are available from time to time.'
    },
    {
      'image': "assets/images/images/pharmplug_icon_row2.png",
      'header': 'Instant Discounts',
      'text': 'Instant discounts are available on products and prescriptions'
    },
  ];
  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";
  getName() async {
    name = await showName();
    surname = await showSurname();

    setState(() {
      name;
      surname;
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

    super.initState();
  }

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
      key: _scaffoldKey,
      drawer: SideBar(
        email: "ayoseunsolomon@gmai.com",
        fullname: "ayo solomon",
        photo: photo,
        
      ),
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: _getSize.width,
              height: _getSize.height,
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
                                  GestureDetector(
                                    onTap: () {
                                      toggleDrawer();
                                    },
                                    child: Image.asset(AppImages.ham,width: _getSize.width*0.08,),
                                  ),
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
                                              "Daniel",
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
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.boy,
                                      width: 56,
                                      height: 56,
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
                        'Your Rented Property',
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.018,
                            fontWeight: FontWeight.w300,
                            color: Pallete.text),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      properties(getSize: _getSize),
                      middle(
                        getSize: _getSize,
                      ),
                      SizedBox(
                        height: _getSize.height * 0.035,
                      ),
                      Text(
                        'Recent Request',
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.018,
                            fontWeight: FontWeight.w300,
                            color: Pallete.text),
                      ),
                      bottom(
                        getSize: _getSize,
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
  const properties({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width,
        height: _getSize.height * 0.45,
        child: ListView.builder(
            itemCount: 1,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.propDetails);
                },
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.condo1,
                      fit: BoxFit.fill,
                      width: _getSize.width,
                      height: _getSize.height*0.25,
                    ),
                    SizedBox(
                      height: _getSize.height * 0.01,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The Spring Lounge",
                              style: AppFonts.boldText.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF333436)),
                            ),
                            SizedBox(
                              height: _getSize.height * 0.005,
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
                                      width: _getSize.width * 0.008,
                                    ),
                                    Text(
                                      "Condo Apartment",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade, fontSize: 14),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.06,
                                ),
                                Row(
                                  children: [
                                    Image.asset(AppImages.location, width: 14),
                                    SizedBox(
                                      width: _getSize.width * 0.008,
                                    ),
                                    Text(
                                      "24 commercial avenue Kampal",
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade, fontSize: 14),
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
                      height: _getSize.height * 0.02,
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
                                  width: _getSize.width * 0.01,
                                ),
                                Text("2")
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              "Bedroom",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
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
                                  width: _getSize.width * 0.01,
                                ),
                                Text("2")
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              "Toilet",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
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
                                  width: _getSize.width * 0.01,
                                ),
                                Text("2")
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              "Bathroom",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
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
                                  width: _getSize.width * 0.01,
                                ),
                                Text("No.1393579")
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
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
                      height: _getSize.height * 0.01,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.wifi,
                              width: 20,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.015,
                            ),
                            Text(
                              "Wifi",
                              style: AppFonts.body1,
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.power,
                              width: 24,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.005,
                            ),
                            Text(
                              "24hrs Power",
                              style: AppFonts.body1,
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.nepa,
                              width: 24,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.005,
                            ),
                            Column(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            
                                Text(
                                  "No.56433323",
                                ),    Text(
                                  "Electricity",
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
              );
            }));
  }
}

class middle extends StatelessWidget {
  const middle({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

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
        width: _getSize.width,
        height: _getSize.height * 0.1,
        child: ListView.builder(
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
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
  const bottom({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

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
        width: _getSize.width,
        height: _getSize.height * 0.17,
        child: ListView.builder(
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 8, left: 4),
                child: Container(
                  height: _getSize.height * 0.1,
                  width: _getSize.width,
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
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          services[index]['icon'],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  services[index]['text'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.text,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.35,
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
                            SizedBox(
                              height: _getSize.height * 0.007,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.6,
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
