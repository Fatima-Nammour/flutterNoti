import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/clippers/forLogin/loginScreenClipper.dart';
import 'package:flutter_assignment/components/clippers/forLogin/loginScreenClipper2.dart';
import 'package:flutter_assignment/components/clippers/forLogin/loginScreenClipper3.dart';

class StackLogin extends StatelessWidget {
  const StackLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: LoginScreenClipper3(),
          child: Container(
            color: Color(0xFF3EC1C9),
            height: height,
            width: width,
          ),
        ),
        ClipPath(
          clipper: LoginScreenClipper2(),
          child: Container(
            color: Color(0xFF36506B),
            height: height,
            width: width,
          ),
        ),
        ClipPath(
          clipper: LoginScreenClipper(),
          child: Container(
            color: Color(0xFFEB467B),
            height: height / 5,
            width: width / 2,
          ),
        ),
      ],
    );
  }
}
