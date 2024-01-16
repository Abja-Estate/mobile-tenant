import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../utils/local_storage.dart';
import '../../utils/time_formatter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var photo = 'https://picsum.photos/200';

  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";

  String createdAt = '';

  var about = 'No Data';
  getData() async {
    name = await showName();
    about = await showAbout();
    surname = await showSurname();
    createdAt = await showCreated();
    photo = await showSelfie();
    if (photo == '') {
      photo = 'https://picsum.photos/200';
    } else {
      photo;
    }
    if (about == '') {
      about = "No Data";
    } else {}
    setState(() {
      createdAt;
      about;
      photo;
      fullname = "$name $surname";
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.navbar, (route) => false);
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      Text("My Profile"),
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
                            fit: BoxFit.cover,
                            width: _getSize.width * 0.22,
                            height: _getSize.height * 0.10,
                              ),
                            ),
                          ),
                        ),
                    
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
                      fullname,
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
                          formatTZDate(createdAt),
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
                bottom(
                  getSize: _getSize,
                  about: about,
                ),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 124),
                  child: ButtonWithFuction(
                      text: 'Log out',
                      onPressed: () {
                        clear();
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
  const middle({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _getSize.height * 0.075,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color(0xFFBBCDD1),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 85, 80, 80),
                  blurRadius: 11,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("05",
                        style: AppFonts.boldText.copyWith(
                          fontSize: _getSize.height * 0.02,
                          color: Color(0xFF1D5A67),
                        )),
                    Image.asset(
                      AppImages.estate,
                      height: _getSize.height * 0.02,
                      color: Color(0xFF1D5A67),
                    ),
                  ],
                ),
                SizedBox(
                  width: _getSize.width * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Active",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF1D5A67),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Rent",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF1D5A67,
                          ),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: _getSize.width * 0.04,
        ),
        Container(
          height: _getSize.height * 0.075,
          width: _getSize.width * 0.28,
          decoration: BoxDecoration(
              color: Color(0xFFFDE7CD),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(68, 85, 80, 80),
                  blurRadius: 11,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("02",
                        style: AppFonts.boldText.copyWith(
                          fontSize: _getSize.height * 0.02,
                          color: Color(0xFFF58807),
                        )),
                    Image.asset(
                      AppImages.request,
                      width: 18,
                      color: Color(0xFFF58807),
                    ),
                  ],
                ),
                SizedBox(
                  width: _getSize.width * 0.04,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Service",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFFF58807),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Request",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFFF58807,
                          ),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({super.key, required Size getSize, required this.about})
      : _getSize = getSize;

  final Size _getSize;
  final String about;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width * 0.9,
        height: _getSize.height * 0.27,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "About",
            style: AppFonts.body1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Pallete.primaryColor),
          ),
          SizedBox(
            height: _getSize.height * 0.005,
          ),
          Container(
            width: _getSize.width * 0.15,
            height: _getSize.height * 0.0015,
            color: Pallete.text,
          ),
          SizedBox(
            height: _getSize.height * 0.0124,
          ),
          SizedBox(
            width: _getSize.width,
            child: Text(
              about,
              style: AppFonts.body1.copyWith(color: Pallete.black),
            ),
          ),
          SizedBox(
            height: _getSize.height * 0.0124,
          ),
          Container(
            width: _getSize.width,
            height: _getSize.height * 0.0007,
            color: Pallete.fade,
          ),
          SizedBox(
            height: _getSize.height * 0.02,
          ),
          items(
            text: "My Cards",
            img: AppImages.card,
          ),
          SizedBox(
            height: _getSize.height * 0.02,
          ),
          items(
            text: "Settings",
            img: AppImages.settings,
          ),
          SizedBox(
            height: _getSize.height * 0.02,
          ),
          items(
            text: "Help and Support",
            img: AppImages.help,
          ),
          SizedBox(
            height: _getSize.height * 0.01,
          ),
        ]));
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
