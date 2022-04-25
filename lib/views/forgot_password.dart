import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_verse_final/misc/bungee_font.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/misc/colors.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        // actions: [],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  width: 250,
                  height: 200,
                  child: Image.asset("assets/images/forgotpasssword.png")),
              SizedBox(
                height: 30,
              ),
              bungeeFont(20, "Reset Password", Colors.black, FontWeight.bold),
              SizedBox(
                height: 15,
              ),
              poppinsFont(13, "Enter the email you used to sign up.",
                  Colors.grey, FontWeight.normal),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _email,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    hintText:
                        "                                          @gmail.com",
                    focusColor: colorScheme.activeStateMain,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0))),
              ),
              Container(
                  margin: EdgeInsets.only(top: 70),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colorScheme.purpleMuch),
                      onPressed: () {
                        if (_email.text == "") {
                          Get.snackbar("Empty", "Please enter your email",
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: colorScheme.inActiveState,
                              colorText: Colors.white);
                        } else {
                          var inputValidator = _email.text;
                          if (inputValidator.contains("@gmail.com")) {
                            //valid email
                          } else {
                            //invalid email
                          }
                        }
                      },
                      child: Text("Reset Password")))
            ],
          ),
        )),
      ),
    );
  }
}
