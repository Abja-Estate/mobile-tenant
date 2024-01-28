import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/constants/app_colors.dart';
import 'package:abjatenant/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/resources.dart';
import '../../../provider/websocket_provider.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({Key? key}) : super(key: key);

  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  int selectedIndex = -1;
  bool isNotSelected = false;
  var agent = "";
  late WebSocketProvider webSocketProvider;

  List job = [];

  bool enabled = false;
  @override
  void initState() {
    enabled=true;
    isNotSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9F5),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const Text("Make A Request"),
                    const Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What do you need?",
                      style: AppFonts.boldText.copyWith(
                          fontSize: 16,
                          color: Pallete.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: _getSize.width,
                        height: _getSize.height * 0.65,
                        child: ListView.builder(
                            itemCount: services.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8),
                                child: GestureDetector(
                                  onTap: () {

                                    
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Pallete.whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                services[index]['icon'],
                                                color: const Color(0xFF47893F),
                                                width: 24,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                services[index]['text'],
                                                style: AppFonts.bodyText
                                                    .copyWith(
                                                        color: const Color(
                                                            0xFF47893F)),
                                              ),
                                            ],
                                          ),
                                          Checkbox(
                                            value: selectedIndex == index,
                                            onChanged: (value) {
                                              selectedIndex =
                                                  value! ? index : -1;

                                              print(selectedIndex);
                                              agent = services[index]['text'];
                                              job = services[index]['job'];

                                              if (selectedIndex == -1) {
                                                enabled = true;
                                              } else {
                                                enabled = false;
                                              }
                                              setState(() {});
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5), // Adjust the radius as needed
                                              side: const BorderSide(
                                                color: Colors
                                                    .green, // Set the border color
                                                width:
                                                    0.5, // Set the border width
                                              ),
                                            ),

                                            activeColor: Colors
                                                .green, // Set the checkbox color
                                            checkColor: Colors
                                                .white, // Set the checkmark color
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ButtonWithFuction(
                    disabled: enabled,
                    text: 'Submit',
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.requestDetails,
                        arguments: {'agent': agent, 'job': job},
                      );
                    }),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
