import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../dashboard/dashboard.dart';
import '../../dashboard/widgets/request_tab.dart';
import '../../navbar/nav.dart';
import '../request.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({Key? key}) : super(key: key);

  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  var requestData;

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    requestData = dataFromRoute['data'];
    final _getSize = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.parse(requestData['time']);
    String formattedTimeDifference = formatTimeDifference(dateTime);
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBar(
                                    initialScreen: RequestScreen(),
                                    initialTab: 1)),
                            (route) => false,
                          );
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      Text("Request Details"),
                   SizedBox(width: 24,)
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    height: _getSize.height * 0.075,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: getIconAssetColor(requestData['agent']),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            getIconAssetName(requestData['agent']),
                            width: _getSize.width * 0.065,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _getSize.width * 0.71,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      requestData['agent'],
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      formattedTimeDifference,
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.007,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.6,
                                child: Text(
                                  requestData['description'],
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
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service needed:",
                     style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          getIconAssetName(requestData['agent']),
                          width: _getSize.width * 0.065,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          requestData['agent'],
                          style: AppFonts.body1.copyWith(
                              color: Pallete.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
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
                      "Request:",
                     style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                                  fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.008,
                    ),
                    SizedBox(
                        height: requestData['problems'].length == 1
                            ? _getSize.height * 0.05
                            : requestData['problems'].length == 2
                                ? _getSize.height * 0.115
                                : _getSize.height * 0.07,
                        width: _getSize.width,
                        child: ListView.builder(
                            itemCount: requestData['problems'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Pallete.whiteColor,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(requestData['problems'][index]),
                                    )),
                              );
                            }))
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request Description",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                                     fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    Text(
                      requestData['description'],
                      style: AppFonts.body1.copyWith(
                        color: Pallete.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Timeline:",
                     style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.calender,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                requestData['day'],
                                style: AppFonts.body1.copyWith(
                                  color: Pallete.text,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          SizedBox(
                              width: _getSize.width * 0.6,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                 
                       
                                  children: [
                                    Icon(Icons.alarm),
                                     SizedBox(
                                width: 4,
                              ),
                                    Text(
                                      requestData['period'],
                                      style: AppFonts.body1.copyWith(
                                        color: Pallete.text,
                                      ),
                                    ),
                                  ],
                                )
,                             
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact:",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.call,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                requestData['phone'],
                                style: AppFonts.body1.copyWith(
                                  color: Pallete.text,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.inboxFilled,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.35,
                                child: Text(
                               requestData['email'],
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1.copyWith(
                                    color: Pallete.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
