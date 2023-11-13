import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  length: 4,
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
                                "Rented",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Service Task",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Property",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            bottom(getSize: _getSize),
                            bottom(getSize: _getSize),
                            bottom(getSize: _getSize),
                            bottom(getSize: _getSize),
                          ],
                        ),
                      ),
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
  const bottom({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.funmigate,
        'color': Color(0xFFEADAFF),
        'text': 'Rent Paid',
        'text2':
            "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
      },
      {
        'icon': AppImages.funmigate,
        'color': Color(0xFFFFE4E9),
        'text': 'Successfully',
        'text2':
            "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning."
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004"
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 16),
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
                    height: _getSize.height * 0.1,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: Pallete.whiteColor,
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Image.asset(
                                services[index]['icon'],
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.6,
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: services[index]['text'],
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: ' - ${services[index]['text2']}',
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.fade,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Icon(Icons.more_vert)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
