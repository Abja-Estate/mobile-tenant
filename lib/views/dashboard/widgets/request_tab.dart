import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../provider/request_provider.dart';
import '../../request/request.dart';

class DashboardRequestMenu extends StatelessWidget {
  const DashboardRequestMenu({
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
        height: getSizeHeight * 0.2,
        child: Consumer<RequestProvider>(
            builder: (context, requestProvider, child) {
          var requestData = requestProvider.request;

    
          if (requestData.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: getSizeHeight * 0.2,
                width: getSizeWidth,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(44, 85, 80, 80),
                    blurRadius: 11,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  )
                ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.noRequest,
                      width: getSizeWidth * 0.6,
                    ),
                    Text('You currently have no Request at this time...')
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: requestData.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                   List<Map<String, dynamic>> sortedData =
                        List.from(requestData);
                    sortedData.sort((a, b) => DateTime.parse(b['time'])
                        .compareTo(DateTime.parse(a['time'])));
                  DateTime dateTime =
                      DateTime.parse(sortedData[index]['time']);
                  String formattedTimeDifference =
                      formatTimeDifference(dateTime);
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8, right: 8, left: 4),
                    child: Container(
                      height: getSizeHeight * 0.07,
                      width: getSizeWidth,
                      decoration: BoxDecoration(
                          color: getIconAssetColor(sortedData[index]['agent']),
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
                              getIconAssetName(sortedData[index]['agent']),
                              width: getSizeWidth * 0.065,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: getSizeWidth * 0.71,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        sortedData[index]['agent'],
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
                                  height: getSizeHeight * 0.007,
                                ),
                                SizedBox(
                                  width: getSizeWidth * 0.6,
                                  child: Text(
                                    sortedData[index]['description'],
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
                });
          }
        }));
  }
}

String getIconAssetName(String iconKey) {
  switch (iconKey) {
    case 'Fumigator':
      return AppImages.fumigator;

    case 'Plumber':
      return AppImages.plumber;
    case 'Gardener':
      return AppImages.gardener;
    case 'Cleaner':
      return AppImages.cleaner;
    case 'Painter':
      return AppImages.painter;
    case 'Mover':
      return AppImages.movers;
    case 'House Agent':
      return AppImages.agent;
    case 'Carpenter':
      return AppImages.carpenter;
    case 'Electrician':
      return AppImages.electrician;
 case 'Paid':
      return AppImages.money;
       case 'Pending':
      return AppImages.pending;
    case 'Reminder':
      return AppImages.clock;
    case 'Approved':
      return AppImages.approved;

    default:
      return AppImages.electrician;
  }
}

Color getIconAssetColor(String iconKey) {
  switch (iconKey) {
    case 'Fumigator':
      return Color(0xFFFFE4E9);

    case 'Plumber':
      return Color(0xFFEADAFF);
    case 'Gardener':
      return Color(0xFFFFDFCC);
    case 'Cleaner':
      return Color(0xFFFBD9D7);
    case 'Painter':
      return Color(0xFFD3F8F1);
    case 'Mover':
      return Color(0xFFDAE7D9);
    case 'House Agent':
      return Color(0xFFDAE7D9);
    case 'Carpenter':
      return Color(0xFFDAE7D9);
    case 'Electrician':
      return Color(0xFFFCEADA);

    default:
      return Color(0xFFFCEADA);
  }
}
