import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: _getSize.width,
            height: _getSize.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      Text("Profile"),
                      Text("")
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Row(
                  children: [
                    Container(
                      width: _getSize.width * 0.37,
                      height: _getSize.height * 0.0007,
                      color: Pallete.primaryColor,
                    ),
                    Stack(
                      children: [
                        DottedBorder(
                          borderType: BorderType.Circle,
                          strokeWidth: 2,
                          color: Color(0xFF47893F),
                          dashPattern: [10, 16],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: Image.network(
                                photo,
                                width: _getSize.width * 0.24,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 82,
                            bottom: 1,
                            left: 70,
                            right: 0,
                            child: SizedBox(
                                width: 4,
                                child: Image.asset(
                                  AppImages.cam,
                                )))
                      ],
                    ),
                    Container(
                      width: _getSize.width * 0.37,
                      height: _getSize.height * 0.0007,
                      color: Pallete.primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Ayo Solomon",
                      style: AppFonts.boldText
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.location,
                          width: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "24, Commercial Avenue, Kampala",
                          style: AppFonts.body1.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.joined,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Joined: 27th January, 2023",
                          style: AppFonts.body1
                              .copyWith(color: Pallete.text, fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.editProfile);
                  },
                  child: Container(
                    width: _getSize.width * 0.3,
                    decoration: BoxDecoration(
                        color: Color(0xFF382D18),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: AppFonts.smallWhiteBold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Container(
                  width: _getSize.width,
                  height: _getSize.height * 0.0007,
                  color: Pallete.primaryColor,
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                middle(getSize: _getSize),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Text("Recommendations"),
                bottom(getSize: _getSize),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 124),
                  child: ButtonWithFuction(
                      text: 'Logout',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.welcomeScreen, (route) => false);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class middle extends StatelessWidget {
  const middle({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {
        'icon': AppImages.agent,
        'color': Color(0xFFDAE7D9),
        'text': 'Properties',
        'text2': "Rented"
      },
      {
        'icon': AppImages.electrician,
        'color': Color(0xFFFCEADA),
        'text': 'Request',
        'text2': "Made"
      }
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: _getSize.width * 0.7,
            height: _getSize.height * 0.1,
            child: ListView.builder(
                itemCount: services.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8,
                        right: _getSize.width * 0.06,
                        left: 4),
                    child: Container(
                      height: _getSize.height * 0.001,
                      width: _getSize.width * 0.3,
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
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: _getSize.width * 0.05,
                            ),
                            Image.asset(services[index]['icon']),
                            SizedBox(
                              width: _getSize.width * 0.005,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  services[index]['text'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.fade,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  services[index]['text2'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.fade,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ],
    );
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
        width: _getSize.width * 0.9,
        height: _getSize.height * 0.2,
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
                      color: Pallete.black,
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
                          AppImages.house,
                          color: Pallete.whiteColor,
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
                                      color: Pallete.whiteColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.35,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rating",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      Icons.star_rate,
                                      size: 14,
                                      color: Color.fromARGB(255, 255, 203, 17),
                                    )
                                  ],
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
