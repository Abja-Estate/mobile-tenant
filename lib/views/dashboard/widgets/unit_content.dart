import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../provider/property_provider.dart';

class DashboardUnitContent extends StatelessWidget {
  const DashboardUnitContent({
    super.key,
    required this.getSizeWidth,
    required this.getSizeHeight,
  });

  final double getSizeHeight;
  final double getSizeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: getSizeWidth,
        height: getSizeHeight * 0.45,
        child: Consumer<PropertyProvider>(
            builder: (context, propertyProvider, child) {
          var unit = propertyProvider.property;

          print(unit);
          if (unit["data"] != null) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.unitDetails,
                    arguments: {"data": unit});
              },
              child: Column(
                children: [
                  Image.network(
                    unit["data"]["photo"],
                    fit: BoxFit.cover,
                    width: getSizeWidth,
                    height: getSizeHeight * 0.25,
                  ),
                  SizedBox(
                    height: getSizeHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unit["propertyName"],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 79, 88, 106)),
                          ),
                          SizedBox(
                            height: getSizeHeight * 0.005,
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
                                    width: getSizeWidth * 0.008,
                                  ),
                                  Text(
                                    unit["propertyStructure"],
                                    style: AppFonts.body1.copyWith(
                                        color: Pallete.fade, fontSize: 14),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: getSizeWidth * 0.06,
                              ),
                              Row(
                                children: [
                                  Image.asset(AppImages.location, width: 14),
                                  SizedBox(
                                    width: getSizeWidth * 0.008,
                                  ),
                                  SizedBox(
                                    width: getSizeWidth * 0.5,
                                    child: Text(
                                      unit["location"],
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade, fontSize: 14),
                                    ),
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
                    height: getSizeHeight * 0.02,
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
                                width: getSizeWidth * 0.01,
                              ),
                              Text(
                                unit["data"]["bedroom"],
                              )
                            ],
                          ),
                          SizedBox(
                            height: getSizeHeight * 0.001,
                          ),
                          Text(
                            "Bedroom",
                            style: AppFonts.bodyText.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        width: getSizeWidth * 0.05,
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
                                width: getSizeWidth * 0.01,
                              ),
                              Text(unit["data"]["toilet"])
                            ],
                          ),
                          SizedBox(
                            height: getSizeHeight * 0.001,
                          ),
                          Text(
                            "Toilet",
                            style: AppFonts.bodyText.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        width: getSizeWidth * 0.05,
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
                                width: getSizeWidth * 0.01,
                              ),
                              Text(unit["data"]["bathroom"])
                            ],
                          ),
                          SizedBox(
                            height: getSizeHeight * 0.001,
                          ),
                          Text(
                            "Bathroom",
                            style: AppFonts.bodyText.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        width: getSizeWidth * 0.05,
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
                                width: getSizeWidth * 0.01,
                              ),
                              Text(unit["data"]["waterMeter"])
                            ],
                          ),
                          SizedBox(
                            height: getSizeHeight * 0.001,
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
                    height: getSizeHeight * 0.01,
                  ),
                  Row(
                    children: [
                      unit["data"]["wifi"]
                          ? Row(
                              children: [
                                Image.asset(
                                  AppImages.wifi,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: getSizeWidth * 0.015,
                                ),
                                Text(
                                  "Wifi",
                                  style: AppFonts.body1,
                                )
                              ],
                            )
                          : Container(),
                      SizedBox(
                        width: getSizeWidth * 0.05,
                      ),
                      unit["data"]["power"]
                          ? Row(
                              children: [
                                Image.asset(
                                  AppImages.power,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: getSizeWidth * 0.005,
                                ),
                                Text(
                                  "24hrs Power",
                                  style: AppFonts.body1,
                                ),
                                SizedBox(
                                  width: getSizeWidth * 0.05,
                                ),
                              ],
                            )
                          : Container(),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.nepa,
                            width: 24,
                          ),
                          SizedBox(
                            width: getSizeWidth * 0.005,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                unit["data"]["lightMeter"],
                              ),
                              Text(
                                "Light Meter",
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
          } else {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F9F5),
                  borderRadius: BorderRadius.circular(10)),
              width: getSizeWidth,
              height: getSizeHeight * 0.25,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SpinKitRing(
                      size: 30,
                      color: Pallete.primaryColor,
                      lineWidth: 2.0,
                    ),
                    Text(
                      "Loading your unit image",
                      style: AppFonts.body1,
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
