import 'package:flutter/material.dart';
import 'package:flutter_assignment/controllers/signupController.dart';
import 'package:flutter_assignment/widgets/stackforprofile.dart';
import 'package:get/get.dart';

class LocalNotyScreen extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Get.lazyPut<SignupController>(() => SignupController(context));
    return Scaffold(
      body: Stack(
        children: [
          StackProfile(),
          SafeArea(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
