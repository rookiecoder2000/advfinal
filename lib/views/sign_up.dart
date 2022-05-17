import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rent_verse_final/misc/bungee_font.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';

import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  String userRole = "";
  int _index = 0;
  double _progress = 0.3;
  final _setLinearProgress = Get.put(signUpController());
  final controllerPage = PageController(initialPage: 0);
  bool _clickedContainer1 = false;
  bool _clickedContainer2 = false;
  Color _containerColor1 = colorScheme.inActiveState;
  Color _containerColor2 = colorScheme.inActiveState;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  void disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  //function sign up

  void signUpUser() async {
    //
    setState(() {
      _isLoading = true;
    });
    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
            userRole: userRole,
            context: context);

    setState(() {
      _isLoading = false;
    });
    if (res != "Success!, Email verification sent!") {
    } else {
      //  disposeControllers();
      controllerPage.nextPage(
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
  }
//landlord

  void signUpUserLandlord() async {
    //
    setState(() {
      _isLoading = true;
    });
    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmailLandlord1(
            email: _emailController.text,
            password: _passwordController.text,
            userRole: userRole,
            context: context);

    setState(() {
      _isLoading = false;
    });
    if (res != "Success!, Email verification sent!") {
    } else {
      //  disposeControllers();
      controllerPage.nextPage(
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: PageView(
        onPageChanged: (int index) {
          setState(() {
            _index = index;
            _progress = _setLinearProgress.lineProgress(_index);
          });
        },
        physics: NeverScrollableScrollPhysics(),
        controller: controllerPage,
        children: [
          //FIRST PAGE ACCOUNT TYPE
          Container(
              child: Column(
            children: [
              LinearProgressIndicator(
                backgroundColor: colorScheme.inActiveState,
                color: colorScheme.purpleMuch,
                value: _progress,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    poppinsFont(20, "Welcome to", colorScheme.activeStateMain,
                        FontWeight.bold),
                    bungeeFont(30, "RENTVERSE", colorScheme.activeStateMain,
                        FontWeight.normal),
                    SizedBox(
                      height: 40,
                    ),
                    poppinsFont(15, "Please choose your role",
                        colorScheme.inputFieldsLabel, FontWeight.normal),
                    SizedBox(
                      height: 10,
                    ),
                    poppinsFont(18, "Tenant", colorScheme.inputFieldsLabel,
                        FontWeight.bold),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (() {
                        userRole = "Tenant";
                        Get.snackbar("Account Type:", "Tenant",
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: colorScheme.inActiveState,
                            colorText: Colors.white);

                        //set bordercolor
                        setState(() {
                          _clickedContainer1 = true;
                          _clickedContainer2 = false;
                          _clickedContainer2
                              ? _containerColor2 = colorScheme.purpleMuch
                              : _containerColor2 = colorScheme.inActiveState;
                          _clickedContainer1
                              ? _containerColor1 = colorScheme.purpleMuch
                              : _containerColor1 = colorScheme.inActiveState;
                        });
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: _containerColor1, width: 2)),
                        height: 150.0,
                        width: 340.0,
                        child: Row(children: [
                          Expanded(
                              child: SvgPicture.asset(
                                  "assets/images/ChooseHouse.svg")),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: poppinsFont(
                                12,
                                "I'm looking for a place \n to rent.",
                                colorScheme.guestButton,
                                FontWeight.normal),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    poppinsFont(18, "Landlord", colorScheme.inputFieldsLabel,
                        FontWeight.bold),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (() {
                        userRole = "Landlord";
                        Get.snackbar("Account Type:", "Landlord",
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.indigo,
                            colorText: Colors.white);
                        setState(() {
                          _clickedContainer2 = true;
                          _clickedContainer1 = false;
                          _clickedContainer1
                              ? _containerColor1 = colorScheme.purpleMuch
                              : _containerColor1 = colorScheme.inActiveState;
                          _clickedContainer2
                              ? _containerColor2 = colorScheme.purpleMuch
                              : _containerColor2 = colorScheme.inActiveState;
                        });
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: _containerColor2, width: 2)),
                        height: 150.0,
                        width: 340.0,
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: poppinsFont(
                                12,
                                "I’m going to enlist my \n boarding  house units \n for renting services.",
                                colorScheme.guestButton,
                                FontWeight.normal),
                          ),
                          Expanded(
                              child: SvgPicture.asset(
                                  "assets/images/AddHouse.svg")),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Get.toNamed("/signin");
                          },
                          child: Text("Return"),
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(150, 40),
                              primary: colorScheme.purpleMuch,
                              side: BorderSide(color: colorScheme.purpleMuch)),
                        ),
                        ElevatedButton(
                            child: Text("Continue"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 40),
                                primary: colorScheme.purpleMuch),
                            onPressed: () {
                              //if user role is assigned
                              if (userRole == "") {
                                Get.snackbar("Select User Type first", "",
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else {
                                controllerPage.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              }
                            })
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
          //SECOND PAGE CREDENTIALS
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: colorScheme.inActiveState,
                    color: colorScheme.purpleMuch,
                    value: _progress,
                  ),
                  //contents of page 3
                  Container(
                    margin: EdgeInsets.only(left: 50, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        bungeeFont(20, "Hang in there,",
                            colorScheme.activeStateMain, FontWeight.bold),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: SvgPicture.asset("assets/images/Money.svg"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 50, bottom: 40),
                        child: bungeeFont(20, "Almost Done!",
                            colorScheme.activeStateMain, FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              poppinsFont(20, "Create Account", Colors.white,
                                  FontWeight.bold),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            decoration: new InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              prefixIcon: Icon(
                                Icons.email,
                                size: 15,
                                color: Colors.white,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            decoration: new InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 15,
                                color: Colors.white,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                                child: Icon(
                                  //Ternary
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureText,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            decoration: new InputDecoration(
                              hintText: 'Re-type password',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 15,
                                color: Colors.white,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  //Ternary
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 40),
                              primary: Colors.pinkAccent),
                          onPressed: () async {
                            //check for missing fields
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              Get.snackbar("Missing Input fields",
                                  "Please fill up missing information.",
                                  snackPosition: SnackPosition.TOP,
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            } else {
                              //check if passwords matches
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                Get.snackbar("Password Doesnt Match", "",
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              } else if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                if (userRole == "Tenant") {
                                  signUpUser();
                                } else if (userRole == "Landlord") {
                                  signUpUserLandlord();
                                }
                              }
                            }
                          },
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text("Confirm"),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: colorScheme.interface,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(120))),
                  ),
                ],
              ),
            ),
          ),

          //THIRD PAGE SUCCESS MESSAGE
          Container(
              child: Column(
            children: [
              LinearProgressIndicator(
                backgroundColor: colorScheme.inActiveState,
                color: colorScheme.interface,
                value: _progress,
              ),
              SizedBox(
                height: 40,
              ),
              bungeeFont(25, "Congratulations", Colors.indigo, FontWeight.bold),
              Container(
                width: 350,
                height: 350,
                child: SvgPicture.asset("assets/images/DoneProfile.svg"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: poppinsFont(
                    15,
                    "You have successfully created \n your RentVerse account. ",
                    colorScheme.grey,
                    FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 40), primary: Colors.indigo),
                onPressed: () {
                  //firebase auth
                  Get.toNamed('/signin');
                },
                child: Text("Proceed to Login Page"),
              ),
            ],
          ))
        ],
      )),
    );
  }
}
