import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Map> services = [
    {'text': 'Leaked Sewer', 'text2': "Rented"},
    {
      'icon': AppImages.electrician,
      'color': Color(0xFFFCEADA),
      'text': 'sewer Repair',
      'text2': "Made"
    },
    {
      'icon': AppImages.electrician,
      'color': Color(0xFFFCEADA),
      'text': 'Drainage Cleaning',
      'text2': "Made"
    },
    {
      'icon': AppImages.electrician,
      'color': Color(0xFFFCEADA),
      'text': 'Others',
      'text2': "Made"
    }
  ];
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
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
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                    ),
                    Text(dataFromRoute["request"]),
                    Text("")
                  ],
                ),
              ),  SizedBox(
                height: _getSize.height * 0.05,
              ),
              SizedBox(
                  width: _getSize.width * 0.9,
                  height: _getSize.height * 0.3,
                  child: ListView.builder(
                      itemCount: services.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Pallete.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                services[index]['text'],
                                style: AppFonts.body1.copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                        );
                      })),
              SizedBox(
                height: _getSize.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonWithFuction(
                    text: 'Done',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.success);
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
