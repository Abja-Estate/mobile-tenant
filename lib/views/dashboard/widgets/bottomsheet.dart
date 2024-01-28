import 'package:abjatenant/utils/property_util/switch_account_utils.dart';
import 'package:abjatenant/views/auth/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../provider/property_provider.dart';

class AccountsBottomSheet extends StatelessWidget {
  const AccountsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Consumer<PropertyProvider>(
          builder: (context, propertyProvider, child) {
        var unit = propertyProvider.rent;
        print(propertyProvider.rent);
        if (unit != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Pallete.fade,
                      borderRadius: BorderRadius.circular(5)),
                  height: 6,
                  width: size.width * 0.15,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  "Accounts",
                  style: AppFonts.boldText.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Pallete.black),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                    height: size.height * 0.2,
                    child: ListView.builder(
                        itemCount: unit.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              SwitchAccountUtil.switchAcc(
                                  context, unit[index]["accessCode"]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF6F9F5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                unit[index]["propertyName"],
                                                style: AppFonts.body1.copyWith(
                                                    fontSize: 14,
                                                    color: Pallete
                                                        .primaryColorVariant,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.006,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 0.16,
                                                    child: Text(
                                                      unit[index]
                                                          ["propertyStructure"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppFonts.bodyText
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  Container(
                                                      height:
                                                          size.height * 0.02,
                                                      width: 1,
                                                      color: Pallete.fade),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.5,
                                                    child: Text(
                                                      unit[index]["accessCode"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppFonts.bodyText
                                                          .copyWith(
                                                              fontSize: 10,
                                                              color:
                                                                  Pallete.text),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.008,
                                              ),
                                              Row(
                                                children: [
                                                  ClipOval(
                                                    child: Image.network(
                                                      unit[index]
                                                          ["landlordPhoto"],
                                                      fit: BoxFit.cover,
                                                      width: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Landlord",
                                                        style: AppFonts.bodyText
                                                            .copyWith(
                                                                fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.02,
                                                      ),
                                                      Container(
                                                          height: size.height *
                                                              0.02,
                                                          width: 1,
                                                          color: Pallete.fade),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.02,
                                                      ),
                                                      Text(
                                                        unit[index]
                                                            ["landlordName"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppFonts.bodyText
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Pallete
                                                                    .text),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          unit[index]["isActive"]
                                              ? Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Pallete
                                                      .primaryColorVariant,
                                                )
                                              : Icon(
                                                  Icons.cancel_outlined,
                                                  color: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  height: size.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome()),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add an existing rented property.",
                        style: AppFonts.body1.copyWith(
                            fontSize: 16,
                            color: Pallete.primaryColorVariant,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
