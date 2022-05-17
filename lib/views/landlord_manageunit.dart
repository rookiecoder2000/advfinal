import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/misc/bungee_font.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/misc/poppins_font.dart';
import 'package:rent_verse_final/misc/showsnackbar.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'dart:math';

import 'package:rent_verse_final/services/firestore_method.dart';
import 'package:rent_verse_final/utils/utils.dart';

class ManageUnits extends StatefulWidget {
  ManageUnits({Key? key}) : super(key: key);

  @override
  State<ManageUnits> createState() => _ManageUnitsState();
}

class _ManageUnitsState extends State<ManageUnits> {
  List<Object> _list = [];
  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  String email = "";
  String uid = '';
  String price = "";
  String roomNumber = "";
  String unitAddress = "";
  String rules = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      final user = context.read<FirebaseAuthMethods>().user;
      uid = user.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          setState(() {
            email = data['email'];
          });
        }
      });
    });
  }

//start of add section
  TextEditingController _price = TextEditingController();
  TextEditingController _roomNumber = TextEditingController();
  TextEditingController _unitAddress = TextEditingController();
  TextEditingController _rules = TextEditingController();
  Uint8List? _file;
  void postImage(
      String price, String roomNumber, String unitAddress, String rules) async {
    try {
      String res = await FirestoreMethods().addUnit(_price.text, _file!, uid,
          _roomNumber.text, _unitAddress.text, _rules.text, email);
      if (res == "success") {
        showSnackBar(context, "Unit Added");
      } else {
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future checkRoomNumber(String roomNumber) async {
    var room = "";
    //find

    return room;
  }

  void clearInputs() {
    _price.clear();
    _roomNumber.clear();
    _unitAddress.clear();
    _rules.clear();
    _image = null;
  }

//end of add section
//remove section
  TextEditingController _removeHouse = TextEditingController();
  final controller = PageController(initialPage: 0);
  bool addClicked = false;
  bool editClicked = false;
  bool removeClicked = false;

  Future addUnit() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).addBoardingHouse(
        price: price,
        roomNumber: roomNumber,
        address: unitAddress,
        rules: rules,
        email: email,
        file: _image!,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.black,
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 12,
        children: [
          SpeedDialChild(
            label: "Add unit",
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            onTap: () {
              controller.animateToPage(1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
            },
            child: Icon(Icons.add),
          ),
          SpeedDialChild(
              label: "Remove unit",
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              child: Icon(Icons.remove),
              onTap: () {
                controller.animateToPage(2,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              }),
          SpeedDialChild(
              label: "Edit unit",
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              child: Icon(Icons.edit),
              onTap: () {
                controller.animateToPage(3,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              })
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Expanded(
              child: Container(
            child: SvgPicture.asset('assets/images/manage.svg'),
          )),

          //add unit
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                      child: bungeeFont(15, "Add Your Units here", Colors.black,
                          FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      //select image
                      selectImage();
                    },
                    child: _image != null
                        ? Container(
                            margin: EdgeInsets.all(20),
                            // child: CircleAvatar(
                            //     radius: 0,
                            //     backgroundImage: MemoryImage(_image!)),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(_image!)),
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                          )
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: Icon(Icons.camera),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                          ),
                  ),
                  poppinsFont(13, "Set unit details here.", Colors.black,
                      FontWeight.bold),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: _price,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Set Monthly Price",
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  size: 16,
                                ),
                                focusColor: colorScheme.purpleMuch,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: _roomNumber,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Room Number",
                                prefixIcon: Icon(
                                  Icons.bed,
                                  size: 16,
                                ),
                                focusColor: colorScheme.purpleMuch,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 370,
                          child: TextField(
                            controller: _unitAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                            maxLines: 5,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                                labelText: "Unit address",
                                prefixIcon: Icon(
                                  Icons.home,
                                  size: 16,
                                ),
                                focusColor: colorScheme.purpleMuch,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 370,
                          child: TextField(
                            controller: _rules,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                            maxLines: 5,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: "Rules",
                                prefixIcon: Icon(
                                  Icons.error,
                                  size: 16,
                                ),
                                focusColor: colorScheme.purpleMuch,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 370,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange),
                        onPressed: () {
                          if (_price.text == "" ||
                              _roomNumber.text == "" ||
                              _unitAddress.text == "" ||
                              _rules.text == "") {
                            Get.snackbar("Missing Fields", "",
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          } else {
                            if (_image == null) {
                              Get.snackbar("Please select image first!", "",
                                  snackPosition: SnackPosition.TOP,
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);
                            } else {
                              setState(() {
                                price = _price.text;
                                roomNumber = _roomNumber.text;
                                unitAddress = _unitAddress.text;
                                rules = _rules.text;
                                //check if room number is already existing
                                checkRoomNumber(roomNumber);
                                addUnit();
                                showSnackBar(context, "Unit added!");
                                clearInputs();
                              });
                            }
                          }
                        },
                        icon: Icon(Icons.check_circle),
                        label: Text("Add unit")),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: bungeeFont(
                        15, "Remove Units", Colors.black, FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  poppinsFont(
                      13, "Enter room ID", Colors.black, FontWeight.bold),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    height: 40,
                    width: 180,
                    child: TextField(
                      controller: _removeHouse,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusColor: colorScheme.purpleMuch,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      //delete
                      if (_removeHouse.text == "") {
                        Get.snackbar("Enter room number first!", "",
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      } else {
                        var collection = FirebaseFirestore.instance
                            .collection('units')
                            .doc(uid)
                            .collection('myUnits');
                        var docSnap = await collection.doc(uid).get();
                        if (docSnap.exists) {
                          Map<String, dynamic>? data = docSnap.data();
                          var value = data?['roomNumber'];
                        }
                        //     .where('roomNumber', isEqualTo: roomNumber)
                        //     .get()
                        //     .then(((value) {}));

// In a method: (one time listen)

// var collection = FirebaseFirestore.instance.collection('users');
// var docSnapshot = await collection.doc('doc_id').get();
// if (docSnapshot.exists) {
//   Map<String, dynamic>? data = docSnapshot.data();
//   var value = data?['some_field']; // <-- The value you want to retrieve.
//   // Call setState if needed.
// }
                        // FirebaseFirestore.instance
                        //     .collection('units')
                        //     .doc(uid)
                        //     .collection('myUnits')
                        //     .doc()
                        //     .get()
                        //     .then((DocumentSnapshot documentSnapshot) {
                        //   if (documentSnapshot.exists) {
                        //     Map<String, dynamic> data =
                        //         documentSnapshot.data() as Map<String, dynamic>;
                        //     setState(() {
                        //       var roomID = data['roomNumber'];
                        //       var occupied = data['isOccupied'];
                        //       if (roomID == _removeHouse.text) {
                        //         if (occupied == "no") {
                        //           showSnackBar(
                        //               context, "Room Successfully removed");
                        //         } else if (occupied == "yes") {
                        //           showSnackBar(context,
                        //               "Could not delete because it's occupied.");
                        //         }
                        //       } else {
                        //         showSnackBar(context, "RoomID does not exist");
                        //         _removeHouse.clear();
                        //       }
                        //     });
                        //   } else {
                        //     showSnackBar(context, "not found");
                        //   }
                        // });
                      }
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Remove House"),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }

  Future getUnitList() async {}
}
