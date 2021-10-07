import 'package:flutter/material.dart';
import 'package:flutter_assignment/controllers/signupController.dart';
import 'package:flutter_assignment/widgets/listviewprofile.dart';
import 'package:flutter_assignment/widgets/stackforprofile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    final spinKit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.pink : Colors.blue,
          ),
        );
      },
    );
    // TODO
    // TODO: implement build
    Get.lazyPut<SignupController>(() => SignupController(context));
    return Scaffold(
      body: controller.obx(
        (state) => Stack(
          children: [StackProfile(), SafeArea(child: ListViewProfile())],
        ),
        onLoading: spinKit,
        onError: (error) => Center(child: Text('Something went wrong')),
      ),
    );
  }
}
