import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class SignupController extends GetxController with StateMixin<File?> {
  SignupController(BuildContext context);
  File? img;
  String name = '';
  String password = '';
  String phone = '';
  String email = '';
  var response;
  var statusCode;

  String getName() => name;

  String getPassword() => password;

  String getPhone() => phone;

  String getEmail() => email;

  File? getImg() => img;

  //setters
  //void setImg(File? image) => this.img = image;

  void setName(String name) => this.name = name;

  void setPassword(String pass) => this.password = pass;

  void setPhone(String ph) => this.phone = ph;

  void setEmail(String em) => this.email = em;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  //Register method
  Future<void> setData(
      File? img, String nm, String phone, String email, String password) async {
    try {
      var uri = Uri.parse('https://flutter--task.herokuapp.com/auth/signUp');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = nm
        ..fields['password'] = password
        ..fields['FCM_token'] = fcm_tocken
        ..fields['email'] = email
        ..fields['phone'] = phone.trim()
        ..files.add(await http.MultipartFile.fromPath('userImg', img!.path));
      change(null, status: RxStatus.loading());
      print('loading');
      response = await request.send();
      final respStr = await response.stream.bytesToString();
      print('return from post');
      print('Response status: ${response.statusCode}');
      print(respStr);
      var temp = json.decode(respStr);
      print(temp["imageUrl"]);
      imgPath = temp["imageUrl"];
      print(response.headers);
      print(response.request);
      if (response.statusCode == 404) {
        statusCode = 404;
        print('Not Found');
        change(null, status: RxStatus.error('Not Found'));
      } else if (response.statusCode == 400) {
        statusCode = 400;
        print("validation error");
        change(null, status: RxStatus.error('Please enter valid email '));
      } else if (response.statusCode == 500) {
        statusCode = 500;
        print("connection error");
        change(null, status: RxStatus.error('Please check connection'));
        print('Success');
      } else if (response.statusCode == 201) {
        statusCode = 201;
        print(imgPath);
        Box.write(keyIsLogged, true);
        print("User Created");
        change(null, status: RxStatus.success());
        print('Success');
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      print('Catch error $e');
      change(null, status: RxStatus.error());
    }
  }
}
