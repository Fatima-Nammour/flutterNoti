import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class LoginController extends GetxController with StateMixin<String> {
  LoginController(BuildContext context);

//  File? img;
  String name = '';
  String password = '';
  String phone = '';
  String email = '';
  var response;
  var statusCode;

  //getters
  //File? getImg() => img!;

  String getName() => name;

  String getPassword() => password;

  String getPhone() => phone;

  String getEmail() => email;

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

  Future<http.Response> postRequest(String em, String pass) async {
    try {
      var uri = Uri.parse('https://flutter--task.herokuapp.com/auth/login');
      Map data = {'email': em, 'password': pass, 'FCM_token': fcm_tocken};
      //encode Map to JSON
      var body = json.encode(data);
      print('loading');
      change(null, status: RxStatus.loading());
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"}, body: body);
      print('return from request');
      print("${response.statusCode}");
      statusCode = response.statusCode;
      print("${response.body}");
      if (response.statusCode == 404) {
        print('user not found');
        change(null, status: RxStatus.error('user not found'));
      } else if (statusCode == 200) {
        //change(null, status: RxStatus.success());
        print('log in successfully');
      }
      return response;
    } catch (e) {
      change(null, status: RxStatus.error('Something went wrong!'));
      return response;
    }
  }
}
