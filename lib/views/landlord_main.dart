import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';

class LandLordMainScreen extends StatefulWidget {
  LandLordMainScreen({Key? key}) : super(key: key);

  @override
  State<LandLordMainScreen> createState() => _LandLordMainScreenState();
}

class _LandLordMainScreenState extends State<LandLordMainScreen> {
  @override
  Widget build(BuildContext context) {
    //access user
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // StreamBuilder(
            //   stream:
            //       FirebaseFirestore.instance.collection('users').snapshots(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData && snapshot != null) {
            //       final docs = snapshot.data;
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //     //
            //   },
            // ),
            Text("Landlords"),
            Text(user.uid),
            ElevatedButton(
                onPressed: () {
                  //
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
                child: Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
