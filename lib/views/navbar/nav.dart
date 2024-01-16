
import 'package:abjatenant/views/notification/notification.dart';
import 'package:abjatenant/views/request/request.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../dashboard/dashboard.dart';


class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //set current tab to starting index
  int currentTab = 0;

  //this is a list of all screents passed into a list that takes widget
  final List<Widget> screens = [Dashboard(),NotificationScreen(),NotificationScreen() ];

//declaring pagestorage state
  final PageStorageBucket Bucket = PageStorageBucket();

  Widget currentScreen = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body:
            //this page storage bucket helps to store each page state in memory
            PageStorage(bucket: Bucket, child: currentScreen),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Color(0xFF0095ff),
        //   child: Icon(Icons.telegram_rounded),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(AppRoutes.dashboard);
        //   },
        // ),
        // //floating action button placed at the center of he navbar
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //set bottomnavbar
        bottomNavigationBar: BottomAppBar(
            //asign shape to navabr
            color: Pallete.whiteColor,
            shape: CircularNotchedRectangle(),
            //set shape to 10px round
            notchMargin: 2,
            child: Container(
              height: 60,
              child: 
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = Dashboard();
                              currentTab = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              currentTab == 0
                                  ? Image.asset(
                                      AppImages.homefilled,
                                      color: Pallete.primaryColor,
                                      width: 25,
                                      height: 25,
                                    )
                                  : Image.asset(
                                      AppImages.home,
                                      color: Pallete.fade,
                                      width: 20,
                                      height: 20,
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Home',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: currentTab == 0
                                        ? FontWeight.bold
                                        : null,
                                    color: currentTab == 0
                                        ? Color(0xC7171A1C)
                                        : Pallete.fade,
                                  )),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = RequestScreen();
                              currentTab = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.request,
                                color: currentTab == 1
                                    ? Color(0xC7171A1C)
                                    : Pallete.fade,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Request',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: currentTab == 1
                                        ? FontWeight.bold
                                        : null,
                                    color: currentTab == 1
                                        ? Color(0xC7171A1C)
                                        : Pallete.fade,
                                  )),
                            ],
                          ),
                        ),
                           MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = NotificationScreen();
                              currentTab = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(Icons.speaker_phone_rounded, color: currentTab == 2
                              //        ? Colors.white
                              //       : Color(0xFF848586),
                              //   size: 20,
                              //   ),
                              Image.asset(
                                AppImages.notification,
                                color: currentTab == 2
                                    ? Color(0xC7171A1C)
                                    : Pallete.fade,
                                height: 20,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Notification',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: currentTab == 2
                                        ? FontWeight.bold
                                        : null,
                                    color: currentTab == 2
                                        ? Color(0xC7171A1C)
                                        : Pallete.fade,
                                  )),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = Dashboard();
                              currentTab = 4;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.inbox,
                                color: currentTab == 4
                                    ? Color(0xC7171A1C)
                                    : Pallete.fade,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text('Inbox',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: currentTab == 4
                                        ? FontWeight.bold
                                        : null,
                                    color: currentTab == 4
                                        ? Color(0xC7171A1C)
                                        : Pallete.fade,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
               
                  
            )));
  }
}
