




import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/resources.dart';

class ServiceProviderRow extends StatelessWidget {
  const ServiceProviderRow({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width,
        height: _getSize.height * 0.1,
        child:
        
         ListView.builder(
            itemCount: services.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                 Navigator.of(context).pushNamed(
                        AppRoutes.requestDetails,
                        arguments: {
                          'agent': services[index]['text'], 'job': services[index]['job'],
                        },
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 8, left: 4),
                  child: Container(
                    height: _getSize.height * 0.001,
                    width: _getSize.width * 0.23,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          services[index]['icon'],
                          width: _getSize.width * 0.06,
                        
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          services[index]['text'],
                          style: AppFonts.body1.copyWith(
                              color: Pallete.fade,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
