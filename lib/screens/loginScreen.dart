import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_assignment/controllers/loginController.dart';
import 'package:flutter_assignment/widgets/listviewlogin.dart';
import 'package:flutter_assignment/widgets/stackforlogin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitRotatingCircle(
      color: Colors.pink,
      size: 50.0,
    );
    // TODO: implement build
    Get.lazyPut<LoginController>(() => LoginController(context));
    return Scaffold(
      body: controller.obx(
        (state) => Stack(
          fit: StackFit.expand,
          children: [
            StackLogin(),
            SafeArea(child: ListViewLogin()),
          ],
        ),
        onLoading: spinKit,
        onError: (error) => Builder(
          builder: (BuildContext context) => Scaffold(
            floatingActionButton: Container(
              width: 200,
              height: 100,
              margin: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/LoginScreen', (route) => false);
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
                        'Try again',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Text(
                'Something went wrong\n$error',
                style: TextStyle(fontSize: 20.0.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
