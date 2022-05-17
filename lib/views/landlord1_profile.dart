import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/utils/utils.dart';

class LandlordProfile1 extends StatefulWidget {
  LandlordProfile1({Key? key}) : super(key: key);

  @override
  State<LandlordProfile1> createState() => _LandlordProfile1State();
}

class _LandlordProfile1State extends State<LandlordProfile1> {
  bool controllerAccess = false;
  String email = "";
  String userRole = "";
  String ln = "", fn = "";
  String gender = "";
  String age = "";
  String phone = "";
  String telephone = "";
  String address = "";
  String city = "";
  String postal = "";
  String dpUrl = "";
  //first approach image picker
  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      final user = context.read<FirebaseAuthMethods>().user;
      var userid = user.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          //check if verified
          var v = data['isVerified'];
          email = data['email'];
          userRole = data['userRole'];
          fn = data['firstName'];
          ln = data['lastName'];
          gender = data['gender'];
          age = data['age'];
          phone = data['phone'];
          telephone = data['telephone'];
          address = data['address'];
          city = data['city'];
          postal = data['postalcode'];
          dpUrl = data['photoUrl'];

          setState(() {
            _genderController.text = gender;
            _ageController.text = age;
            _phoneController.text = phone;
            _telephoneController.text = telephone;
            _addressController.text = address;
            _cityController.text = city;
            _postalController.text = postal;
          });
        }
      });
    });
  }

  void refreshCred() async {
    //refresh controllers
    setState(() {
      final user = context.read<FirebaseAuthMethods>().user;
      var userid = user.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          //check if verified
          var v = data['isVerified'];
          setState(() {
            email = data['email'];
            userRole = data['userRole'];
            fn = data['firstName'];
            ln = data['lastName'];
            _genderController.text = data['gender'];
            _ageController.text = data['age'];
            _phoneController.text = data['phone'];
            _telephoneController.text = data['telephone'];
            _addressController.text = data['address'];
            _cityController.text = data['city'];
            _postalController.text = data['postalcode'];
          });
        }
      });
    });
  }

  Future updateLandLord() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).updateLandlordProfile(
        gender: _genderController.text,
        age: _ageController.text,
        phone: _phoneController.text,
        telephone: _telephoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        postalcode: _postalController.text,
        file: _image!,
        context: context);
  }
//first name _ last name

  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalController = TextEditingController();
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: colorScheme.purpleMuch,
            elevation: 0,
            title: Text("My Profile"),
            centerTitle: true,
            actions: []),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.purpleMuch,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 30, bottom: 50, right: 20),
                        width: 150,
                        height: 150.0,
                        child: InkWell(
                          onTap: (() {
                            //upload photo
                            selectImage();
                          }),
                          child: _image != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(dpUrl)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            poppinsFont(18, fn + " " + ln, Colors.white,
                                FontWeight.bold),
                            poppinsFont(
                                13, userRole, Colors.white, FontWeight.normal),
                            poppinsFont(
                                12, email, Colors.white, FontWeight.w100),
                            SizedBox(
                              height: 20,
                            ),
                            verified
                                ? Icon(
                                    Icons.warning,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: poppinsFont(11, "Gender", colorScheme.inputFieldsLabel,
                    FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _genderController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.male,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(
                    11, "Age", colorScheme.inputFieldsLabel, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.numbers,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(
                    11, "Phone", colorScheme.inputFieldsLabel, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.phone_android,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(11, "Telephone",
                    colorScheme.inputFieldsLabel, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _telephoneController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(11, "Address", colorScheme.inputFieldsLabel,
                    FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.pin_drop,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(
                    11, "City", colorScheme.inputFieldsLabel, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _cityController,
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.location_city,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 20),
                child: poppinsFont(11, "Postal Code",
                    colorScheme.inputFieldsLabel, FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  enabled: controllerAccess,
                  controller: _postalController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.purpleMuch),
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.purpleMuch),
                    prefixIcon: Icon(
                      Icons.local_post_office,
                      size: 20,
                      color: colorScheme.purpleMuch,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.grey, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: colorScheme.purpleMuch, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 40,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                    onPressed: () {
                      setState(() {
                        controllerAccess = !controllerAccess;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 40,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check),
                    label: Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                        primary: controllerAccess ? Colors.green : Colors.grey),
                    onPressed: () async {
                      if (controllerAccess) {
                        setState(() {
                          controllerAccess = !controllerAccess;

                          updateLandLord();
                          //save storage

                          Get.snackbar("Changes Saved!", "",
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        });
                        setState(() {
                          refreshCred();
                        });
                      } else {
                        //do nothing
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
