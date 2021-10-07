import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/keys.dart';
import 'package:flutter_assignment/controllers/signupController.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';

class ListViewSignup extends GetView<SignupController> {
  //EditingControllers
  final TextEditingController nameTextCont = TextEditingController();
  final TextEditingController passwordTextCont = TextEditingController();
  final TextEditingController phoneTextCont = TextEditingController();
  final TextEditingController emailTextCont = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SignupController>(() => SignupController(context));
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        SizedBox(
          height: height * 0.08,
        ),
        //Text
        Container(
          margin: EdgeInsets.only(
            left: 30.0,
          ),
          child: Text(
            'Create \nAccount!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 45.0,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        //TextField Name
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          //width: width / 2 + width * 0.30,
          child: TextFormField(
            controller: nameTextCont,
            onChanged: (text) {
              print('before onchange   $text');
              controller.name = text;
              print(controller.name);
            },
            style: TextStyle(
              fontSize: 18.0.sp,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white),
              focusColor: Color(0xFF36506B),
            ),
          ),
        ),
        //TextField Password
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          width: width / 2 + width * 0.30,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              validator: (String? value) {
                return (value != null && value.length < 6)
                    ? ' length of password should be at least 6'
                    : null;
              },
              controller: passwordTextCont,
              onChanged: (text) {
                print('before onchange   $text');
                controller.password = text;
                print(controller.password);
              },
              style: TextStyle(fontSize: 18.0.sp, color: Colors.blue),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Color(0xFF36506B),
              ),
            ),
          ),
        ),
        //TextField Email
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          //width: width / 2 + width * 0.30,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: emailTextCont,
              onChanged: (text) {
                print('before onchange   $text');
                controller.email = text;
                print(controller.email);
              },
              style: TextStyle(fontSize: 18.0.sp, color: Colors.blue),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Color(0xFF36506B),
              ),
            ),
          ),
        ),
        //TextField phone number
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          width: width / 2 + width * 0.30,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              validator: (String? value) {
                return (value != null && value.length < 10)
                    ? ' length of phone should be 10'
                    : null;
              },
              controller: phoneTextCont,
              onChanged: (text) {
                print('before onchange   $text');
                controller.phone = text.trim();
                print(controller.phone);
              },
              style: TextStyle(fontSize: 18.0.sp, color: Colors.blue),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Phone',
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Color(0xFF36506B),
              ),
            ),
          ),
        ),
        //Button Register
        //Register and go ProfileScreen
        Container(
          width: 100,
          height: 100,
          margin:
              EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
          child: InkWell(
            onTap: () async {
              print(controller.name);
              print(controller.email);
              print(controller.password);
              print(controller.phone);

              //////////////////////////
              if (controller.phone.length < 10) {
                await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('length of phone should be 10 '),
                        actions: [
                          ElevatedButton(
                            child: Text(
                              'OK ',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
              if (controller.password.isEmpty ||
                  controller.password.length < 6) {
                await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('length of password should be at least 6 '),
                        actions: [
                          ElevatedButton(
                            child: Text(
                              'OK ',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
              if (controller.img == null) {
                await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Please Choose a photo'),
                        actions: [
                          ElevatedButton(
                            child: Text(
                              'OK ',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
              if (controller.password.trim().length >= 6 &&
                  controller.phone.length == 10 &&
                  controller.img!.path != '') {
                print('path of file ${controller.img!.path}');
                print(controller.phone.trim().length);
                print(controller.phone);

                //Call request method
                await controller.setData(
                    controller.img,
                    controller.getName(),
                    controller.getPhone().trim(),
                    controller.getEmail(),
                    controller.getPassword());
              }
              if (controller.statusCode == 201) {
                Box.write(keyName, controller.name);
                Box.write(keyPassword, controller.password);
                Box.write(keyPhoneNumber, controller.phone);
                Box.write(keyEmail, controller.email);
                Box.write(keyImgPath, controller.img!.path);
                Navigator.pushNamed(context, '/ProfileScreen');
              }
            },
            child: Stack(
              children: [
                Positioned(
                  right: 30.0,
                  top: 0.0,
                  bottom: 10.0,
                  child: ClipOval(
                      child: Container(
                    width: 100,
                    height: 10,
                    color: Color(0xFFFFE589),
                  )),
                ),
                Positioned(
                  right: 70.0,
                  top: 20.0,
                  bottom: 20.0,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Login ,Choose photo Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Choose Photo
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 30.0),
                child: InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? image1 =
                        await _picker.pickImage(source: ImageSource.gallery);
                    image = File(image1!.path);
                    controller.img = image;
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Choose Photo',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
              ),
            ),
            //Login Button
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 30.0),
                child: InkWell(
                  onTap: () {
                    print('go login');
                    Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen',
                        (Route<dynamic> route) => false);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
