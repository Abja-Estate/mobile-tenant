
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../utils/local_storage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  final List<Map<String, dynamic>> _slidiingItem = [
    {
      "title": "Request for Maintenance & Repairs",
      "desc": "Request reliable home service professionals for maintenance and repairs.",
      "img": AppImages.first
    },
    {
      "title": "Track your Requests",
      "desc":
          "As a tenant, you’re able to track the status of your requests in real-time ",
      "img": AppImages.second
    },
    {
      "title": "Rental Payments",
      "desc":
          "Make rental payments securely through the app using any of payment integrations.",
      "img": AppImages.third
    },
   
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _getSize.height * 0.75,
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: _slidiingItem.length,
                    itemBuilder: (context, index) {
                      // contents of slider
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: _getSize.height * 0.01,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.welcomeScreen);
                              },
                              child: Text(
                                'Skip >>>',
                                style: AppFonts.bodyText.copyWith(
                                    fontSize: _getSize.height * 0.02,
                                    fontWeight: FontWeight.w600,
                                    color: Pallete.secondaryColor),
                              ),
                            ),
                            SizedBox(
                              height: _getSize.height * 0.05,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.9,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset(_slidiingItem[index]['img'])),
                            ),
                            SizedBox(
                              height: _getSize.height * 0.06,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _slidiingItem[index]['title'],
                                  style: AppFonts.boldText.copyWith(
                                      fontSize: _getSize.width * 0.055,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF47893F)),
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.01,
                                ),
                                Text(
                                  _slidiingItem[index]['desc'],
                                  style: AppFonts.bodyText.copyWith(
                                      fontSize: _getSize.width * 0.035,
                                      fontWeight: FontWeight.w600,
                                      color: Pallete.text),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slidiingItem.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(''),
                    Container(
                      width: _getSize.width * 0.55,
                      height: _getSize.height * 0.05,
                      decoration: BoxDecoration(
                          color: Pallete.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: GestureDetector(
                          child: Text(
                            currentIndex == _slidiingItem.length - 1
                                ? "Continue"
                                : "Next",
                            style: AppFonts.smallWhiteBold.copyWith(fontSize: 20),
                          ),
                          onTap: () {
                            if (currentIndex == _slidiingItem.length - 1) {
                              saveOnce(1);
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.welcomeScreen);
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NavBar()),
                              // );
                            }
                            _controller.nextPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // container created for dots
  Widget buildDot(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 17,
        width: 17,
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color: currentIndex == index
                  ? Color(0xFF47893F)
                  : Color.fromARGB(255, 209, 214, 211)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: currentIndex == index
                    ? Color(0xFF47893F)
                    : Color.fromARGB(255, 209, 214, 211)),
          ),
        ),
      ),
    );
  }
}
