import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_assignment/controllers/NotyController.dart';
import 'package:flutter_assignment/widgets/stackforprofile.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotyScreen extends GetView<NotyController> {
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
    // TODO: implement build
    Get.lazyPut<NotyController>(() => NotyController(context));
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          StackProfile(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () async {
                      print('after call');
                    }
                    /*() async {
                      var boolSend = await sendFcmMessage(
                          'Hello', 'How are you my friend');
                      print('Send Hello');
                      print(boolSend);
                    }*/
                    ,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(
                      'Send Hello',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20.0.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 30.0),
                  child: InkWell(
                    onTap: () async {
                      var boolSend = await controller.sendFcmMessage(
                          'Bye', 'Sure you want to exit the app?');

                      print(boolSend);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(
                      'Send Bye',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20.0.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          //SafeArea(child: ListViewLogin()),
        ],
      ),
    );
  }
}
