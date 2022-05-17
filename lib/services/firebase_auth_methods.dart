import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:packages_info/packages_info.dart';
import 'package:rent_verse_final/main.dart';
import 'package:rent_verse_final/misc/showsnackbar.dart';
import 'package:rent_verse_final/models/landlord_users.dart';
import 'package:rent_verse_final/services/storage_service.dart';
import 'package:rent_verse_final/views/loading.dart';
import 'package:rent_verse_final/views/sign_up.dart';

class FirebaseAuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);
  User get user => _auth.currentUser!;

  //verification phase
  Future<void> addLandlordCredential(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String birthdate,
      required String age,
      required String gender,
      required String phone,
      required String telephone,
      required String address,
      required String city,
      required String postalCode}) async {
    try {
      //add
      var currentUserID = _auth.currentUser!.uid;
      _firestore.collection('users').doc(currentUserID).update({
        'isVerified': "verified",
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'age': age,
        'birthDate': birthdate,
        'gender': gender,
        'phone': phone,
        'telephone': telephone,
        'city': city,
        'postalCode': postalCode
      });

      //update verification status to verified
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> addBoardingHouse(
      {required String price,
      required String roomNumber,
      required String address,
      required String rules,
      required String email,
      required Uint8List file,
      required BuildContext context}) async {
    String res = "Some error";
    var currentUserID = _auth.currentUser!.uid;
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('boardingHouse', file, false);
      _firestore
          .collection('units')
          .doc(currentUserID)
          .collection('myUnits')
          .doc()
          .set({
        'price': price,
        'roomNumber': roomNumber,
        'address': address,
        'rules': rules,
        'uid': currentUserID,
        'email': email,
        'isOccupied': "no",
        'isVisible': "no",
        'occupyingTenant': "",
        'photoUrl': photoUrl
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return currentUserID;
  }

  Future<String> updateLandlordProfile(
      {
      // required String email,
      // required String userRole,
      required String gender,
      required String age,
      required String phone,
      required String telephone,
      required String address,
      required String city,
      required String postalcode,
      required Uint8List file,
      required BuildContext context}) async {
    String res = "Some error occured";
    var currentUserID;
    try {
      currentUserID = _auth.currentUser!.uid;
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);
      _firestore.collection('users').doc(currentUserID).update({
        'age': age,
        'gender': gender,
        'phone': phone,
        'telephone': telephone,
        'address': address,
        'city': city,
        'postalcode': postalcode,
        'photoUrl': photoUrl
      });
    } on FirebaseException catch (e) {
      //error
    }

    return currentUserID;
  }

  //landlord
  Future<String> signUpWithEmailLandlord({
    required String email,
    required String password,
    //  required String userName,
    required String userRole,
    required BuildContext context,
  }) async {
    String res = "Some error occured";
    try {
      //register
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add to firestore databse
      _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': email,
        'userRole': userRole,
        'isVerified': "unverified",
        'firstName': "",
        'lastName': "",
        'occupation': "",
        'birthdate': "",
        'age': "",
        'gender': "",
        'phone': "",
        'telephone': "",
        'address': "",
        'city': "",
        'postalcode': "",
        'tenants': [],
        'units': [],
        'photoUrl': ""
      });
      res = "Success!, Email verification sent!";
      sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        showSnackBar(context, "Email Badly formatted");
      } else if (e.code == "") {
        showSnackBar(context, "Weak Password");
      } else {
        showSnackBar(context, e.message!);
      }
    }
    return res;
  }

  Future<String> signUpWithEmail(
      {required String email,
      required String password,
      //  required String userName,
      required String userRole,
      required BuildContext context}) async {
    String res = "Some error occured";
    try {
      //register
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add to firestore databse
      _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': email,
        'userRole': userRole,
        'isVerified': "unverified",
        'firstName': "",
        'lastName': "",
        'occupation': "",
        'birthdate': "",
        'age': "",
        'gender': "",
        'phone': "",
        'telephone': "",
        'address': "",
        'city': "",
        'postalcode': "",
        'photoUrl': ""
        //image
      });
      res = "Success!, Email verification sent!";
      sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        showSnackBar(context, "Email Badly formatted");
      } else if (e.code == "") {
        showSnackBar(context, "Weak Password");
      } else {
        showSnackBar(context, e.message!);
      }
    }
    return res;
  }

//state
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
//FirebaseAuth.instance.userChanges();
//FirebaseAuth.instance.idTokenchanges();

  //email verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email verification sent!");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Get.toNamed('/signin');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //email log in

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed('/load');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<String> signUpWithEmailLandlord1(
      {required String email,
      required String password,
      //  required String userName,
      required String userRole,
      required BuildContext context}) async {
    String res = "Some error occured";
    try {
      //register
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add to firestore databse
      LandlordUsers luser = LandlordUsers(
          uid: cred.user!.uid,
          photoUrl: "",
          firstName: "",
          lastName: "",
          age: "",
          birthDate: "",
          gender: "",
          city: "",
          postal: "",
          isVerified: "unverified",
          phone: "",
          telephone: "",
          userRole: userRole,
          email: email,
          address: "",
          tenants: [],
          units: []);

      _firestore.collection('users').doc(cred.user!.uid).set(luser.toJson());
      res = "Success!, Email verification sent!";
      sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        showSnackBar(context, "Email Badly formatted");
      } else if (e.code == "") {
        showSnackBar(context, "Weak Password");
      } else {
        showSnackBar(context, e.message!);
      }
    }
    return res;
  }
}
