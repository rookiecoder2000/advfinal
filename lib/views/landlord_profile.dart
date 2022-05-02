import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/views/verified_page.dart';

class LandlordProfile extends StatefulWidget {
  LandlordProfile({Key? key}) : super(key: key);

  @override
  State<LandlordProfile> createState() => _LandlordProfileState();
}

//if not verified then stepper if verified return edit2
class _LandlordProfileState extends State<LandlordProfile> {
  bool isCompleted = false;
  int currentStep = 0;
  DateTime _dateTime = DateTime.now();
  String _formattedDate = "";
  String ageLabel = "";
  var age;
  var flexValue;
  var day, year, month;
  var hint = "mm/dd/yyyy";
  bool _isLoading = false;
  //TextEdittingControllers
  TextEditingController _ageController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _homeAddressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  String gender = "";
  void addUsercredential() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuthMethods(FirebaseAuth.instance).addLandlordCredential(
        context: context,
        firstName: _firstnameController.text,
        lastName: _lastnameController.text,
        occupation: _occupationController.text,
        birthdate: _birthDateController.text,
        age: _ageController.text,
        gender: gender,
        phone: _phoneController.text,
        telephone: _telephoneController.text,
        address: _homeAddressController.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Verification Process"),
      ),
      body: isCompleted
          ? verificationCompleted()
          : Stepper(
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                //check if all textfields in phase 1 are complete
                if (currentStep == 0) {
                  //birthdate,age, gender, firstname, lastname, occupation
                  if (_ageController.text == "" ||
                      _birthDateController.text == "" ||
                      gender == "" ||
                      _firstnameController.text == "" ||
                      _lastnameController.text == "" ||
                      _occupationController.text == "") {
                    Get.snackbar(
                        "Missing fields", "Please fill up all the fields first",
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(milliseconds: 3000),
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                }
                //check if all textfields in phase 2 are complete
                else if (currentStep == 1) {
                  if (_phoneController.text == "" ||
                      _telephoneController.text == "") {
                    Get.snackbar(
                        "Missing fields", "Please fill up all the fields first",
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(milliseconds: 3000),
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                }
                //check if all textfields in phase 3 are complete
                else if (currentStep == 2) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (_cityController.text == "" ||
                      _homeAddressController.text == "" ||
                      _postalCodeController.text == "") {
                    Get.snackbar(
                        "Missing fields", "Please fill up all the fields first",
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(milliseconds: 3000),
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                  } else {
                    if (isLastStep) {
                      setState(() {
                        addUsercredential();
                        isCompleted = true;
                        //update user info

                        //dispose all controllers
                        // Get.toNamed('/verified');
                        //proceed to verified page
                      });
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  }
                }
              },
              onStepCancel: () {
                setState(() {
                  if (currentStep == 0) {
                  } else {
                    currentStep -= 1;
                  }
                });
                //   currentStep == 0 ? null : () => setState(() => currentStep -= 1);
              },
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text("Personal Information"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      labelText: 'Firstname',
                      hintText: 'Enter your first name',

                      // Enabled Border
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      // Focused Border
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent, width: 3),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                      labelText: 'Lastname',
                      hintText: 'Enter your last name',

                      // Enabled Border
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      // Focused Border
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent, width: 3),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _occupationController,
                    decoration: InputDecoration(
                      labelText: 'Occupation',
                      hintText: 'Enter your job name',

                      // Enabled Border
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      // Focused Border
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent, width: 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // height: 60,
                    child: TextField(
                        readOnly: true,
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          labelText: "Birthdate",
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo)),
                          suffixIcon: IconButton(
                            onPressed: (() async {
                              //
                              DateTime? _birthDate = await showDatePicker(
                                  context: context,
                                  initialDate: _dateTime,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());

                              if (_birthDate != null) {
                                setState(() {
                                  final DateFormat formatter =
                                      DateFormat('MM/dd/yyyy');

                                  _formattedDate = formatter.format(_birthDate);
                                  hint = _formattedDate;
                                  int currentYear = _dateTime.year;
                                  day = int.parse(
                                      DateFormat("dd").format(_birthDate));
                                  year = int.parse(
                                      DateFormat("yyyy").format(_birthDate));
                                  month = int.parse(
                                      DateFormat("MM").format(_birthDate));

                                  age = currentYear - year;
                                  if (age >= 18) {
                                    _birthDateController.text =
                                        _formattedDate.toString();
                                    setState(() {
                                      //  age = _birthDateController.text;
                                      _ageController.text = age.toString();
                                    });
                                  } else {
                                    Get.snackbar("Age Inappropriate",
                                        "PAge must be at least 18+.",
                                        snackPosition: SnackPosition.TOP,
                                        duration: Duration(milliseconds: 3000),
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white);
                                    age = "Age is illegal.";
                                  }
                                });
                              }
                            }),
                            icon: Icon(
                              Icons.calendar_month,
                              size: 16,
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(),
                        )),
                  ),
                  TextField(
                    controller: _ageController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Age",

                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      // Focused Border
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent, width: 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  poppinsFont(13, "Choose your gender",
                      colorScheme.inputFieldsLabel, FontWeight.bold),
                  Row(
                    children: [
                      InkWell(
                        onTap: (() {
                          setState(() {
                            gender = "male";
                            Get.snackbar("Male", "",
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(milliseconds: 3000),
                                backgroundColor: Colors.blue,
                                colorText: Colors.white);
                          });
                        }),
                        child: Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Container(
                                child: Image.asset("assets/images/male.png"),
                                width: 50,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: (() {
                          setState(() {
                            gender = "female";
                            Get.snackbar("Female", "",
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(milliseconds: 3000),
                                backgroundColor: Colors.pink,
                                colorText: Colors.white);
                          });
                        }),
                        child: Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Container(
                              child: Image.asset("assets/images/female.png"),
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text("Contact Information"),
            content: Column(
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.contact_phone),
                    prefixIconColor: Colors.indigo,
                    labelText: 'Phone Number',
                    hintText: '+63',

                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                ),
                TextField(
                  controller: _telephoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.numbers),
                    prefixIconColor: Colors.indigo,
                    labelText: 'Telephone Number',
                    hintText: '',

                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text("Additional information"),
            content: Column(
              children: [
                TextField(
                  controller: _homeAddressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_pin),
                    prefixIconColor: Colors.indigo,
                    labelText: 'Home Address',
                    hintText: '',

                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                ),
                TextField(
                  controller: _cityController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    prefixIconColor: Colors.indigo,
                    labelText: 'City',
                    hintText: '',

                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                ),
                TextField(
                  controller: _postalCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.code),
                    prefixIconColor: Colors.indigo,
                    labelText: 'Postal Code',
                    hintText: 'ex. 8000',

                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                ),
              ],
            ))
      ];

  verificationCompleted() {
    return UserVerified();
  }
}
