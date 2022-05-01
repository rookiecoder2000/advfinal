import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:packages_info/packages_info.dart';
import 'package:rent_verse_final/misc/showsnackbar.dart';
import 'package:rent_verse_final/views/sign_up.dart';

class FirebaseAuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);
  User get user => _auth.currentUser!;

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
        'isVerified': "unverified"
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
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
