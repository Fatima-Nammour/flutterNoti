import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/keys.dart';
import 'package:flutter_assignment/controllers/signupController.dart';
import 'package:flutter_assignment/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListViewProfile extends GetView<SignupController> {
  final TextEditingController nameTextCont = TextEditingController();
  final TextEditingController passwordTextCont = TextEditingController();
  final TextEditingController phoneTextCont = TextEditingController();
  final TextEditingController emailTextCont = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    Get.lazyPut<SignupController>(() => SignupController(context));

    return Form(
      child: ListView(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          //Image Network
          Stack(children: [
            Center(
              child: CircleAvatar(
                  maxRadius: 20.w,
                  minRadius: 10.w,
                  backgroundColor: Colors.black54,
                  //radius: 50.sp,
                  child: ClipOval(
                    child: imgPath == null
                        ? Container(
                            child: Image.asset(
                              'assets/images/3.png',
                              height: width * 0.6,
                              width: width * 0.6,
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : Container(
                            child: Image.network(
                              imgPath,
                              height: width * 0.6,
                              width: width * 0.6,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                  )),
            ),
            Positioned(
                bottom: 5.w,
                right: 30.w,
                child: Container(
                  height: 10.0.w,
                  width: 10.0.w,
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFEB467B),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
          ]),
          SizedBox(
            height: height * 0.01,
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
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Name',
                hintText: Box.read(keyName),
                labelStyle: TextStyle(color: Colors.black),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Password',
                  hintText: Box.read(keyPassword),
                  labelStyle: TextStyle(color: Colors.black),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Email',
                  hintText: Box.read(keyEmail),
                  labelStyle: TextStyle(color: Colors.black),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Phone',
                  hintText: Box.read(keyPhoneNumber),
                  labelStyle: TextStyle(color: Colors.black),
                  focusColor: Color(0xFF36506B),
                ),
              ),
            ),
          ),
          //Button
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(
                top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
            child: Stack(
              children: [
                Positioned(
                  right: 30.0,
                  top: 0.0,
                  bottom: 10.0,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    onTap: () => print('Circle'),
                    child: ClipOval(
                        child: Container(
                      width: 100,
                      height: 10,
                      color: Color(0xFFFFE589),
                    )),
                  ),
                ),
                Positioned(
                  right: 80.0,
                  top: 20.0,
                  bottom: 16.0,
                  child: InkWell(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image
                      final XFile? image1 =
                          await _picker.pickImage(source: ImageSource.gallery);
                      image = File(image1!.path);
                      controller.img = image;
                    },
                    focusColor: Colors.transparent,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
