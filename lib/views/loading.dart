import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/auth_service.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/views/landlord_main.dart';
import 'package:rent_verse_final/views/sign_in.dart';
import 'package:rent_verse_final/views/tenant_main.dart';

class Load extends StatefulWidget {
  Load({Key? key}) : super(key: key);

  @override
  State<Load> createState() => _LoadState();
}

bool isLoading = true;

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = context.read<FirebaseAuthMethods>().user;
    var userid = user.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Something went wrong");
          //return SignInScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          var userRole = data['userRole'];
          if (userRole == "Landlord") {
            return LandLordMainScreen();
          } else if (userRole == "Tenant") {
            return TenantMainScreen();
          }
        }

        return Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Signing in..."),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Colors.indigo,
              )
            ],
          ),
        );
      },
    );
  }

  Future getUserRole() async {
    final user = context.read<FirebaseAuthMethods>().user;
    var userid = user.uid;
    var data = await FirebaseFirestore.instance.collection('users').doc(userid);
    //final uid = AuthService()
  }
}

class GetUser {
  String? role;
  GetUser.fromSnapshot(snapshot) : role = snapshot.data()['userRole'];
}
