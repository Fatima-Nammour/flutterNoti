import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/clippers/forSignup/signupScreenClipper.dart';
import 'package:flutter_assignment/components/clippers/forSignup/signupScreenClipper2.dart';
import 'package:flutter_assignment/components/clippers/forSignup/signupScreenClipper3.dart';

class StackSignup extends StatelessWidget {
  const StackSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: SignupScreenClipper3(),
          child: Container(
            color: Color(0xFF3EC1C9),
            height: height,
            width: width,
          ),
        ),
        ClipPath(
          clipper: SignupScreenClipper2(),
          child: Container(
            color: Color(0xFF36506B),
            height: height,
            width: width,
          ),
        ),
        ClipPath(
          clipper: SignupScreenClipper(),
          child: Container(
            color: Color(0xFFEB467B),
            height: height,
            width: width,
          ),
        ),
      ],
    );
  }
}
