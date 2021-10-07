import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:timezone/data/latest.dart';

class NotyController extends GetxController with StateMixin<String> {
  NotyController(BuildContext context);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    initializeTimeZones();

    //_firebaseMessaging.getToken();
    print('lklkl$fcm_tocken');
    super.onInit();
    change(null, status: RxStatus.success());
  }

  //the following method is needed for locally noty

  //The following method show a noty

  //The method sends a noty with FCM Token
  Future<bool> sendFcmMessage(String title, String message) async {
    String serverKey =
        "AAAASO6o3aM:APA91bFNw1mnqrOqyeFq6jANNjFl92LmJevO6Np8t64yyG8h6TP8iI2ANbfL56u5sOiViV6WZe8lF3SGqemCEkudBH0xY9iNozvfCh8Zna2TgtWbgSEXTEJ8Gh_3SS9CgNhAM1gvbAbC";
    try {
      var uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var header = {
        "Content-Type": "application/json",
        "Authorization": "key=$serverKey"
      };
      var request = {
        "notification": {
          "title": title,
          "body": message,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'COMMENT'
        },
        "priority": "high",
        "to": fcm_tocken,
      };
      print('begin');
      var client = new Client();
      var response =
          await client.post(uri, headers: header, body: json.encode(request));
      print('after post');
      print(response.body);
      return true;
    } catch (e, s) {
      print('catch  $e');
      return false;
    }
  }
}
