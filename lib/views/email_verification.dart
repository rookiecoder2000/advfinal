import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';

class EmailVerificationSent extends StatelessWidget {
  const EmailVerificationSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email verification sent!, Please check your email."),
            ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/signin');
                },
                icon: Icon(Icons.verified),
                label: Text("Proceed to login after verifying")),
            // Text("No verification received?"),
            // ElevatedButton.icon(
            //     onPressed: () {
            //       context
            //           .read<FirebaseAuthMethods>()
            //           .sendEmailVerification(context);
            //     },
            //     icon: Icon(Icons.verified),
            //     label: Text("Resend link to email"))
          ],
        ),
      ),
    );
  }
}
