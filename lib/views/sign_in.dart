import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/misc/bungee_font.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/views/forgot_password.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String userID = "";
  //login user function
  void loginUser() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: 300,
                height: 150,
                child: Image(image: AssetImage("assets/images/rent.ico"))),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 0,
              color: colorScheme.activeStateMain,
            ),
            SizedBox(
              height: 10,
            ),
            bungeeFont(20, "RentVerse ", Colors.blueAccent, FontWeight.bold),
            bungeeFont(30, "LOGIN ", Colors.blueAccent, FontWeight.bold),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 40,
              width: 250,
              child: TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.mail,
                      size: 16,
                    ),
                    focusColor: colorScheme.purpleMuch,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20),
              height: 40,
              width: 250,
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 16,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    focusColor: colorScheme.activeStateMain,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40), primary: colorScheme.interface),
                onPressed: () {
                  loginUser();
                },
                icon: Icon(Icons.lock),
                label: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 13),
                )),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                Get.toNamed("/onboarding");
              },
              child: Text("Sign Up"),
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  primary: colorScheme.interface,
                  side: BorderSide(color: colorScheme.interface)),
            ),
            SizedBox(
              height: 30,
            ),
            RichText(
                text: TextSpan(
                    text: "Forgot password?  ",
                    style: TextStyle(
                      color: colorScheme.inputFieldsLabel,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                    children: [
                  TextSpan(
                      text: "Click here",
                      style: TextStyle(
                          color: colorScheme.purpleMuch,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ForgotPassword()),
                          //  );
                        })
                ]))
          ],
        ),
      ),
    ));
  }
}
