import 'package:flutter/material.dart';

class LandlordProfile1 extends StatefulWidget {
  LandlordProfile1({Key? key}) : super(key: key);

  @override
  State<LandlordProfile1> createState() => _LandlordProfile1State();
}

class _LandlordProfile1State extends State<LandlordProfile1> {
  bool editMode = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: editMode ? Text("Edit Profile") : Text("My Profile"),
            centerTitle: true,
            actions: []),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              //temporary only
              color: Colors.indigo,
              width: 50,
              height: 50.0,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/ninja.png"),
              ),
            )
          ],
        )),
      ),
    );
  }
}
