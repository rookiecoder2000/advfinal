import 'package:flutter/material.dart';

class EmailVerificationSent extends StatelessWidget {
  const EmailVerificationSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Email verification sent!"),
      ),
    );
  }
}
