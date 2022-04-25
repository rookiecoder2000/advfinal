import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rent_verse_final/misc/bungee_font.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';

import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String userRole = "";

  int _index = 0;
  double _progress = 0.3;
  final _setLinearProgress = Get.put(signUpController());
  final controllerPage = PageController(initialPage: 0);
  bool _clickedContainer1 = false;
  bool _clickedContainer2 = false;
  Color _containerColor1 = colorScheme.inActiveState;
  Color _containerColor2 = colorScheme.inActiveState;
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
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsFont(20, "Welcome to", colorScheme.activeStateMain,
                    FontWeight.bold),
                bungeeFont(30, "RENTVERSE", colorScheme.activeStateMain,
                    FontWeight.normal),
                LinearProgressIndicator(
                  backgroundColor: colorScheme.inActiveState,
                  color: colorScheme.purpleMuch,
                  value: _progress,
                ),
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
                        border: Border.all(color: _containerColor1, width: 2)),
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
                        border: Border.all(color: _containerColor2, width: 2)),
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
                          child:
                              SvgPicture.asset("assets/images/AddHouse.svg")),
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
          )),
          //SECOND PAGE CREDENTIALS
          Container(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  poppinsFont(
                      20, " ", colorScheme.activeStateMain, FontWeight.bold),
                  bungeeFont(25, "almost done!", colorScheme.activeStateMain,
                      FontWeight.normal),
                  LinearProgressIndicator(
                    backgroundColor: colorScheme.inActiveState,
                    color: colorScheme.purpleMuch,
                    value: _progress,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 160,
                        height: 180,
                        child: SvgPicture.asset("assets/images/Almost.svg"),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
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
                            //firebase

                            controllerPage.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          })
                    ],
                  )
                ],
              ),
            ),
          )),
          //THIRD PAGE SUCCESS MESSAGE
          Container(
              child: Column(
            children: [
              LinearProgressIndicator(
                backgroundColor: colorScheme.inActiveState,
                color: colorScheme.purpleMuch,
                value: _progress,
              ),
              ElevatedButton(
                  onPressed: () => controllerPage.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeIn),
                  child: Text("Continue")),
              ElevatedButton(
                  onPressed: () => controllerPage.previousPage(
                      duration: Duration(seconds: 1), curve: Curves.easeIn),
                  child: Text("Return")),
            ],
          ))
        ],
      )),
    );
  }
}
