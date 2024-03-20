import 'dart:convert';

import 'package:abjatenant/utils/app_utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_stack/image_stack.dart';
import '../../../components/buttons.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../utils/local_storage.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  void initState() {
  
    super.initState();
  }



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

  var unit;
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    unit = dataFromRoute["data"];
    print(unit);
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
                      Text("My Unit"),
                      Text("")
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  Image.network(
                    unit["data"]["photo"],
                    fit: BoxFit.cover,
                    width: _getSize.width,
                    height: _getSize.height * 0.25,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                unit["propertyName"],
                                style: AppFonts.boldText.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                unit["data"]["tenantInfo"]["added_at"],
                                style: AppFonts.body1
                                    .copyWith(fontWeight: FontWeight.w600),
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
                                    unit["propertyStructure"],
                                    style:
                                        AppFonts.body1.copyWith(fontSize: 14),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: _getSize.width * 0.05,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 252, 212, 51),
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
                                unit["location"],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade, fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          Row(
                            children: [
                              NewWidget(
                                getSize: _getSize,
                                holder: "Bedroom",
                                data: unit["data"]["bedroom"],
                                img: AppImages.bedroom,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.025,
                              ),
                              NewWidget(
                                getSize: _getSize,
                                holder: "Bathroom",
                                data: unit["data"]["bathroom"],
                                img: AppImages.bathroom,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.025,
                              ),
                              NewWidget(
                                getSize: _getSize,
                                holder: "Toilet",
                                data: unit["data"]["toilet"],
                                img: AppImages.toilet,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.025,
                              ),
                              NewWidget(
                                getSize: _getSize,
                                holder: "Store",
                                data: unit["data"]["store"] == ""
                                    ? "0"
                                    : unit["data"]["store"],
                                img: AppImages.store,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.025,
                              ),
                              NewWidget(
                                getSize: _getSize,
                                holder: "Light  Meter",
                                data: unit["data"]["lightMeter"],
                                img: AppImages.nepa,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Row(
                            children: [
                              NewWidget(
                                getSize: _getSize,
                                holder: "Water Meter",
                                data: unit["data"]["waterMeter"],
                                img: AppImages.nepa,
                              ),
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
                              SizedBox(
                                width: _getSize.width,
                                child: Text(
                                  unit["propertyDescription"],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1,
                                ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Landlord",
                                style: AppFonts.boldText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.text,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.005,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      unit["landlordSelfie"],
                                      fit: BoxFit.cover,
                                      width: _getSize.width * 0.14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: _getSize.width * 0.45,
                                        child: Text(unit["fullName"],
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.text,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(
                                        height: _getSize.height * 0.003,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.location,
                                            width: 14,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.45,
                                            child: Text(
                                              unit["location"],
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.text),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.02,
                          ),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                                "Cost",
                                style: AppFonts.boldText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.text,
                                    fontSize: 14),
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Row(
                                        children: [
                                          Text(
                                            "Monthly Cost",
                                            style: AppFonts.body1.copyWith(
                                                fontSize: 12,
                                                color: Pallete.fade,
                                               ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "*",
                                            style: AppFonts.bodyText.copyWith(
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0)),
                                          ),
                                        ],
                                      ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFDAE7D9)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("USh${unit["data"]["monthlyCost"]}",style: AppFonts.body1.copyWith(fontSize: 12,color: Pallete.text),),
                                          Text(" / month",style: AppFonts.body1.copyWith(fontSize: 12,color: Pallete.text),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                              , SizedBox(
                            height: _getSize.height * 0.02,
                          ),  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Row(
                                        children: [
                                          Text(
                                            "Extra Charges",
                                            style: AppFonts.body1.copyWith(
                                                fontSize: 12,
                                                color: Pallete.fade,
                                               ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "*",
                                            style: AppFonts.bodyText.copyWith(
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0)),
                                          ),
                                        ],
                                      ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFDAE7D9)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("USh${unit["data"]["extraWages"]}",style: AppFonts.body1.copyWith(fontSize: 12,color: Pallete.text),),
                                          Text(" / month",style: AppFonts.body1.copyWith(fontSize: 12,color: Pallete.text),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                           ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rent Duration",
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
                                  Text(
                                    "Start Date:",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.body1,
                                  ),
                                  Text(
                                    unit["data"]["tenantInfo"]["startDate"],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.body1,
                                  ),
                                  Text("")
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.0055,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "End Date:",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.body1,
                                  ),
                                  Text(
                                    unit["data"]["tenantInfo"]["endDate"],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.body1,
                                  ),
                                  Text("")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.025,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Documents",
                                style: AppFonts.boldText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.text,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.005,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppUtils.showDocPhoto(context,
                                      unit['data']['tenantInfo']['idPhoto']);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F9F5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.pdf,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.025,
                                        ),
                                        Text(
                                          "National ID/Passport",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.smallWhiteBold
                                              .copyWith(
                                                  color: Pallete.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.0025,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppUtils.showDocPhoto(
                                      context,
                                      unit['data']['tenantInfo']
                                          ['rentalPhoto']);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F9F5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.doc,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.025,
                                        ),
                                        Text(
                                          "Agreement",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.smallWhiteBold
                                              .copyWith(
                                                  color: Pallete.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppUtils.showDocPhoto(
                                      context,
                                      unit['data']['tenantInfo']
                                          ['receiptPhoto']);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F9F5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.png,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: _getSize.width * 0.025,
                                        ),
                                        Text(
                                          "Reciept",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.smallWhiteBold
                                              .copyWith(
                                                  color: Pallete.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required Size getSize,
    required this.holder,
    required this.data,
    required this.img,
  }) : _getSize = getSize;

  final Size _getSize;

  final String img;
  final String data;
  final String holder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              img,
              width: 24,
            ),
            SizedBox(
              width: _getSize.width * 0.01,
            ),
            Text(data)
          ],
        ),
        SizedBox(
          height: _getSize.height * 0.001,
        ),
        Text(
          holder,
          style: AppFonts.bodyText.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
