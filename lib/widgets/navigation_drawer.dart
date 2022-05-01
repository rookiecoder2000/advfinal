import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';

class NavigationDrawerWidgetLandlords extends StatefulWidget {
  NavigationDrawerWidgetLandlords({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidgetLandlords> createState() =>
      _NavigationDrawerWidgetLandlordsState();
}

class _NavigationDrawerWidgetLandlordsState
    extends State<NavigationDrawerWidgetLandlords> {
  String email = "";
  String fn = "";
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    //get user info

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
        if (v == "verified") {
          setState(() {
            isVerified = true;
          });
        } else if (v == "unverified") {
          setState(() {
            isVerified = false;
            fn = "Hello, user.";
          });
        }
        setState(() {
          email = data['email'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var urlImage = "assets/images/";
    return Drawer(
      child: Material(
        color: colorScheme.interface,
        child: ListView(
          padding: EdgeInsets.only(left: 20),
          children: <Widget>[
            buildHeader(urlImage = urlImage,
                name: fn,
                email: email,
                //add
                onClicked: isVerified

                    //samtingwong
                    ? () => Get.toNamed("/landlordProfile1")
                    : () => Get.toNamed("/landlordProfile")),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Appointments',
                icon: Icons.book_online,
                onClicked: () => selectedItem(context, 0)),
            SizedBox(
              height: 16,
            ),
            buildMenuItem(text: 'Messages', icon: Icons.message),
            SizedBox(
              height: 16,
            ),
            buildMenuItem(
                text: 'Current Tenants',
                icon: Icons.groups,
                onClicked: () => selectedItem(context, 2)),
            SizedBox(
              height: 16,
            ),
            buildMenuItem(text: 'Your location', icon: Icons.map),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(
              height: 180,
            ),
            buildMenuItem(
                onClicked: () => selectedItem(context, 4),
                text: 'Logout',
                icon: Icons.logout),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Get.toNamed("/landlordAppointments");
        break;
      case 2:
        Get.toNamed("/landlordTenantsList");
        break;
      case 4:
        context.read<FirebaseAuthMethods>().signOut(context);
        break;
    }
  }

  buildHeader(String s,
          {required String name,
          required String email,
          //  required bool isVerified,
          required VoidCallback onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/ninja.png"),
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    isVerified ? Icons.verified_user : Icons.warning,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(email,
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ],
          ),
        )),
      );
}
