import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_stack/image_stack.dart';
import '../../../components/buttons.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  int _currentIndex = 0;
  final List<String> imgList = [
    AppImages.condo1,
    AppImages.condo2,
    // ... add more image URLs
  ];
  final CarouselController _carouselController = CarouselController();
  String formattedDate = "";
  void maind() {
    final DateTime now = DateTime.now();
    formattedDate = formatDate(now);
    print(formattedDate);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM, y').format(dateTime);
  }

  @override
  void initState() {
    maind();
    super.initState();
  }

  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];
  List<Map<String, dynamic>> features = [
    {"icon": AppImages.football, "text": "Football"},
    {"icon": AppImages.swim, "text": "Pool"},
    {"icon": AppImages.wifi, "text": "Wifi"},
    {"icon": AppImages.flower, "text": "Garden"},
    {"icon": AppImages.laundry, "text": "Laundry"}
  ];
    List<Map<String, dynamic>> features2 = [
    {"icon": AppImages.weightlifting, "text": "Fitness"},
    {"icon": AppImages.power, "text": "24 hrs Power"},
    {"icon": AppImages.wifi, "text": "Wifi"},
    {"icon": AppImages.flower, "text": "Garden"},
    {"icon": AppImages.laundry, "text": "Laundry"}
  ];
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
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
                      Text("Property Details"),
                      Text("")
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: _getSize.height * 0.25,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imgList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Ensure the container takes the full width
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(
                                      15), // Provides the curved border
                                ),
                                child: ClipRRect(
                                  // Clip the image to match the border radius
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(item, fit: BoxFit.fill),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 10, // adjust position as needed
                        left: 0, right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.map((url) {
                            int index = imgList.indexOf(url);
                            return Container(
                              width: 32.0,
                              height: 4.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.2, color: Pallete.fade),
                                borderRadius: BorderRadius.circular(2),
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Pallete.fade,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        top: 100, // adjust position as needed
                        left: 10,
                        child: ClipOval(
                          child: Container(
                            width: _getSize.width * 0.08,
                            height: _getSize.height * 0.037,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.2, color: Pallete.fade),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 16,
                              ),
                              onPressed: () {
                                _carouselController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100, // adjust position as needed
                        right: 10,
                        child: ClipOval(
                          child: Container(
                            width: _getSize.width * 0.08,
                            height: _getSize.height * 0.037,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.2, color: Pallete.fade),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                              onPressed: () {
                                _carouselController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.47,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "The Spring Lounge",
                                      style: AppFonts.boldText.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: AppFonts.body1.copyWith(fontWeight: FontWeight.w600),
                                    )
                                  ],
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
                                          width: 18,
                                          color: Pallete.primaryColor,
                                        ),
                                        Text(
                                          "Condo Apartment",
                                          style: AppFonts.body1
                                              .copyWith(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.05,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 18,
                                          color:
                                              Color.fromARGB(255, 252, 212, 51),
                                        ),
                                        Text(
                                          "4.7",
                                          style: AppFonts.body1,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.005,
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
                                SizedBox(
                                  height: _getSize.height * 0.015,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: AppFonts.boldText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Pallete.text,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.0035,
                                    ),
                                    Text(
                                      "Bright, spacious 2-bedroom apartment in a quiet neighborhood. Close to shops, restaurants, and public transportation.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts.body1,
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: _getSize.height * 0.025,
                                ),

                                //Features
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Features",
                                      style: AppFonts.boldText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Pallete.text,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Features(_getSize, features, 4),
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Features(_getSize, features2, 2),
                                    SizedBox(
                                      width: _getSize.width * 0.02,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.015,
                                ),
                                Column(
                                  children: [],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.015,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tenants",
                                      style: AppFonts.boldText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Pallete.text,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ImageStack(
                                          imageList: images,
                                          backgroundColor:
                                              Color.fromARGB(49, 209, 209, 209),
                                          extraCountTextStyle: AppFonts.body1
                                              .copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                          totalCount: images
                                              .length, // If larger than images.length, will show extra empty circle
                                          imageRadius:
                                              45, // Radius of each images
                                          imageCount:
                                              3, // Maximum number of images to be shown in stack
                                          imageBorderWidth:
                                              0.6, // Border width around the images
                                        ),
                                        Text(
                                          "See More",
                                          style: AppFonts.body1.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Pallete.secondaryColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _getSize.height * 0.015,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox Features(Size _getSize, List features, int lng) {
    return SizedBox(
      width: _getSize.width,
      height: _getSize.height * 0.05,
      child: ListView.builder(
          itemCount: lng,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Pallete.fade),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        features[index]['icon'],
                        width: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _getSize.width * 0.015,
                  ),
                  Text(
                    features[index]['text'],
                    style: AppFonts.body1,
                  )
                ],
              ),
            );
          }),
    );
  }
}
