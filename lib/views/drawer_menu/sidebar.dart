import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';
import '../../utils/local_storage.dart';

class SideBar extends StatelessWidget {
  String email = 'your email';
  String fullname = '';

  var photo;
  inituser() async {
    var close = await clear();

    close;
  }

  SideBar({
    Key? key,
    required this.email,
    required this.fullname,
    required this.photo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
          color: Pallete.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SafeArea(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Image.asset(
                          AppImages.ham2,
                          width: _getSize.width * 0.11,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          ClipOval(
                              child: Image.network(
                            photo,
                            width: _getSize.width * 0.12,
                          )),
                          SizedBox(
                            width: _getSize.width * 0.01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullname,
                                style: AppFonts.body1.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF382D18)),
                              ),
                              Text(
                                email,
                                style: AppFonts.body1.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Color(0xFF382D18)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    children: [
                      items(
                        text: "Profile",
                        route: AppRoutes.profile,
                        img: AppImages.profile,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        route: AppRoutes.unitDetails,
                        text: "My Rented Property",
                        img: AppImages.estate,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "Requests",
                        img: AppImages.request,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "Services",
                        img: AppImages.services,
                      ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // items(
                      //   text: "My Cards",
                      //   img: AppImages.card,
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // items(
                      //   text: "Settings",
                      //   img: AppImages.settings,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "General",
                        style: AppFonts.body1.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Pallete.primaryColor),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.help,
                            width: 24,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.02,
                          ),
                          Text(
                            "Help and Support",
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Pallete.primaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.about);
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.profile,
                              width: 24,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.02,
                            ),
                            Text(
                              "Emergency Contact",
                              style: AppFonts.body1.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Pallete.primaryColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Legal",
                        style: AppFonts.body1.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Pallete.primaryColor),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.tc,
                            width: 24,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.02,
                          ),
                          Text(
                            "Terms and Conditions",
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Pallete.primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.welcomeScreen, (route) => false);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.logout,
                          width: 24,
                        ),
                        SizedBox(
                          width: _getSize.width * 0.02,
                        ),
                        Text(
                          "Log Out",
                          style: AppFonts.body1.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Pallete.primaryColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class items extends StatelessWidget {
  const items({super.key, required this.text, required this.img, this.route});
  final String text;
  final String img;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route!);
      },
      child: Container(
        width: double.infinity, // Expands to fill the available space
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Image.asset(
                  img,
                  width: 24,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: AppFonts.body1.copyWith(
                      fontWeight: FontWeight.w900, color: Pallete.primaryColor),
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF47893F),
            )
          ],
        ),
      ),
    );
  }
}
