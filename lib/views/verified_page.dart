import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserVerified extends StatelessWidget {
  const UserVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            child: SvgPicture.asset('assets/images/verification.svg'),
          ),
        ),
      ],
    ));
  }
}
