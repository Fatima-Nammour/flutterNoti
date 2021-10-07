import 'package:flutter/material.dart';
import 'package:flutter_assignment/controllers/signupController.dart';
import 'package:flutter_assignment/widgets/listviewsignup.dart';
import 'package:flutter_assignment/widgets/stackSignup.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    const spinKit = SpinKitRotatingCircle(
      color: Colors.pink,
      size: 70.0,
    );
    // TODO: implement build
    Get.lazyPut<SignupController>(() => SignupController(context));
    return Scaffold(
      body: controller.obx(
        //first param is a success state always
        (state) => Stack(
          children: [
            StackSignup(),
            SafeArea(child: ListViewSignup()),
          ],
        ),
        onLoading: spinKit,

        //I use the builder widget to solve (Navigator operation requested with a
        // context that does not include a Navigator.)problem
        //The problem is, MyApp is actually a parent of MaterialApp.
        // As it's the widget who instantiate MaterialApp! Therefore MyApp's BuildContext
        // doesn't have a MaterialApp as parent!
        // To solve this problem, we need to use a different context.
        // In this situation, the easiest solution is to introduce
        // a new widget as child of MaterialApp. And then use that
        // widget's context to do the Navigator call.

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
                      context, '/SignupScreen', (route) => false);
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
//Text('Something went wrong')
