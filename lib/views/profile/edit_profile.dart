import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/components/input_field.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';
import '../../utils/validator.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
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
                    Text("Edit Profile"),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Stack(
                      children: [
                        DottedBorder(
                          borderType: BorderType.Circle,
                          strokeWidth: 2,
                          color: Color(0xFF47893F),
                          dashPattern: [10, 16],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: Image.network(
                                photo,
                                width: _getSize.width * 0.24,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 82,
                            bottom: 1,
                            left: 70,
                            right: 0,
                            child: SizedBox(
                                width: 4,
                                child: Image.asset(
                                  AppImages.cam,
                                )))
                      ],
                    ),
                   
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'fullname',
                      hint: 'Full Name',
                      onSaved: (value) {},
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'email/phone',
                      hint: 'Phone Number or Email',
                      onSaved: (value) {},
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'password',
                      hint: 'Password',
                      onSaved: (value) {},
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'password',
                      hint: 'Confirm Password',
                      onSaved: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 64),
                child: ButtonWithFuction(
                    text: 'Save Changes',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.navbar);
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
