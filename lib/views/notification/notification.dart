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
 bool isLoaded=false;

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
                    isLoaded ? Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            bottom(getSize: _getSize),
                            bottom(getSize: _getSize),
                            bottom(getSize: _getSize),
                           
                          ],
                        ),
                      ):Container(child: Center(child: Column(
                        children: [
                          SizedBox(height: _getSize.height*0.15,),
                          Image.asset(AppImages.noNotification),
                          Text("You currently have no Notification")
                        ],
                      ),),)
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
        'icon': AppImages.plumber,
        'color': Color(0xFFFCEADA),
        'text': 'Painter',
        'text2': "Painting of Apartment 004",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2':   "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      }, {
        'icon': AppImages.fumigator,
        'color': Color(0xFFEADAFF),
        'text': 'Rent Paid',
        'text2':
            "Agent Emmanuel has received rent payment from Miss Susan for June 2023.",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text3':"Alert!",
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFFFE4E9),
            'text': 'Successfully',
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
       
        ]
      },
     
      {
        'icon': AppImages.fumigator,
        'color': Color(0xFFEADAFF),
        'text': 'Rent Paid',
        'text2':
            "Agent Emmanuel has received rent payment from Miss Susan for June 2023.",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFFFE4E9),
            'text': 'Front',
              'text3':"1st Floor",
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
          {
            'icon': AppImages.electrician,
            'color': Color(0xFFDAE7D9),
            'text': '2nd Floor- Back',
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
        ]
      },
      {
        'icon': AppImages.fumigator,
        'color': Color(0xFFFFE4E9),
        'text': 'Successfully',
        'text2':
            "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property.",
        'data': [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text3':"Alert!",
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFDAE7D9),
        'text': '2nd Floor- Back',
        'text2': "Mr. Eric is in need of house cleaning.",
        "data": [
          {
            'icon': AppImages.plumber,
            'color': Color(0xFFFCEADA),
            'text': 'Painter',
            'text2': "Painting of Apartment 004"
          },
          {
            'icon': AppImages.fumigator,
            'color': Color(0xFFEADAFF),
            'text': 'Rent Paid',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
        ]
      },
    ];
    return Padding(
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
                                :services[index]['data'].length == 4
                        ? _getSize.height * 0.3
                        : _getSize.height * 0.3,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today",
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height:  services[index]['data'].length == 1
                                ? _getSize.height * 0.06 // For length < 2
                                :services[index]['data'].length == 2
                                ? _getSize.height * 0.11 // For length < 2
                                : services[index]['data'].length == 3
                                    ? _getSize.height * 0.17 // For length < 3
                                    : services[index]['data'].length == 4
                                        ? _getSize.height *
                                            0.24 // For length < 4
                                        : _getSize.height *
                                            0.24, // For length >= 4
                            child: buildListItem(context,
                                services[index]['data'], _getSize.width),
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

Widget buildListItem(BuildContext context, List<Map<String, dynamic>> service,
    double getSizeWidth) {
  // Assuming AppFonts and Pallete are defined elsewhere in your project.
  return ListView.builder(
      itemCount: service.length,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(service[index]['icon'],width: getSizeWidth*0.06,),
              const SizedBox(width: 12),
              SizedBox(
                width: getSizeWidth * 0.6,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                     service[index]['text3']!=null?  TextSpan(
                        text: service[index]['text3'],
                        style: TextStyle(
                          color: service[index]['text3']!='Alert!'? Colors
                              .black:Color.fromARGB(255, 224, 10, 10), // Replace with Pallete.black if defined
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ):TextSpan(
                        text: '',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      service[index]['text3']!=null?  TextSpan(
                        text: ' - ',
                        style: TextStyle(
                          color:  Colors
                              .black,// Replace with Pallete.black if defined
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ):TextSpan(
                        text: '',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '${service[index]['text']} ',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' - ${service[index]['text2']}',
                        style: TextStyle(
                          color: Colors
                              .grey, // Replace with Pallete.fade if defined
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.more_vert),
            ],
          ),
        );
      });
}
