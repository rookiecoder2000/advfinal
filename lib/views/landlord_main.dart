import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/views/landlord_manageunit.dart';
import 'package:rent_verse_final/misc/colors.dart';
import 'package:rent_verse_final/widgets/navigation_drawer.dart';

//access user
// ElevatedButton(
//     onPressed: () {
//       //
//       context.read<FirebaseAuthMethods>().signOut(context);
//     },
//     child: Text("Sign out"))
// final user = context.read<FirebaseAuthMethods>().user;
//return Scaffold(
class LandLordMainScreen extends StatefulWidget {
  LandLordMainScreen({Key? key}) : super(key: key);

  @override
  State<LandLordMainScreen> createState() => _LandLordMainScreenState();
}

class _LandLordMainScreenState extends State<LandLordMainScreen> {
  int currentIndex = 1;
  final screens = [
    Container(
      child: Center(
        child: Text("Analytics"),
      ),
    ),
    Container(
      child: Center(
        child: Text("asd"),
      ),
    ),
    ManageUnits(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidgetLandlords(),
      appBar: AppBar(
        backgroundColor: colorScheme.purpleMuch,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          selectedLabelStyle: TextStyle(
              fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w100),
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: "Overview & Analytics",
              backgroundColor: colorScheme.purpleMuch,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Room List",
              backgroundColor: colorScheme.purpleMuch,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest),
              label: "Manage units",
              backgroundColor: colorScheme.purpleMuch,
            )
          ]),
    );
  }
}
