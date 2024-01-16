import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abjatenant/components/buttons.dart';
import 'package:abjatenant/components/input_field.dart';
import 'package:abjatenant/constants/app_routes.dart';
import 'package:abjatenant/utils/app_utils.dart';
import 'package:abjatenant/utils/auth_utils/update_userdata_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import '../../constants/app_images.dart';
import '../../utils/local_storage.dart';
import '../../utils/validator.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var photo = 'https://picsum.photos/200';
  final _updateFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _updateData = {
    'email': '',
    'password': '',
    'confirmPassword': "",
    "phone": "",
    "name": "",
    "surname": "",
    "about": "",
    "selfie": ""
  };
  bool isFetchingImage = false;
  bool isuploaded = false;

  imgpika.XFile? image; //this is the state variable
  upload() async {
    final imgpika.ImagePicker _picker = imgpika.ImagePicker();
    final img = await _picker.pickImage(source: imgpika.ImageSource.gallery);
    if (img != null) {
      File imageFile = File(img.path);
      Uint8List imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);
      setState(() {
        print(base64String);
        _updateData['selfie'] = base64String;
        isuploaded = true;
      });
    }
  }

  getData() async {
    photo = await showSelfie();
    if (photo == '') {
      photo = 'https://picsum.photos/200';
    } else {
      photo;
    }

    setState(() {
      photo;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
              GestureDetector(
                onTap: () {
                  upload();
                },
                child: Stack(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      strokeWidth: 2,
                      color: Color(0xFF47893F),
                      dashPattern: [10, 16],
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: !isuploaded
                              ? Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                  width: _getSize.width * 0.25,
                                  height: _getSize.height * 0.12,
                                )
                              : Image.memory(
                                  base64Decode(_updateData['selfie']),   fit: BoxFit.cover,
                                    width: _getSize.width * 0.25,
                                  height: _getSize.height * 0.12,
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
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _updateFormKey,
                  child: Column(
                    children: [
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'First Name',
                        hint: 'First Name',
                        onSaved: (value) {
                          _updateData['name'] = value;
                        },
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'Last Name',
                        hint: 'Last Name',
                        onSaved: (value) {
                          _updateData['surname'] = value;
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.04,
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'Email',
                        hint: 'Email',
                        onSaved: (value) {
                          _updateData['email'] = value;
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.04,
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'Phone',
                        hint: 'Phone',
                        onSaved: (value) {
                          _updateData['phone'] = value;
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.04,
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'About',
                        hint: 'About',
                        onSaved: (value) {
                          _updateData['about'] = value;
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.04,
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'password',
                        hint: 'Password',
                        onSaved: (value) {
                          _updateData['password'] = value;
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.04,
                      ),
                      CustomInput3(
                        validator: Validators.nameValidator,
                        label: 'password',
                        hint: 'Confirm Password',
                        onSaved: (value) {
                          _updateData['confirmPassword'] = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 64),
                child: ButtonWithFuction(
                    text: 'Save Changes',
                    onPressed: () {
                      UpdateUtil.update(_updateFormKey, context, _updateData);
                    }),
              ),  SizedBox(
                height: _getSize.height * 0.1,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
