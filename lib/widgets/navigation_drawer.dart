import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_verse_final/misc/colors.dart';

class NavigationDrawerWidgetLandlords extends StatelessWidget {
  NavigationDrawerWidgetLandlords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = "Joah Cyrus";
    final email = "joah@gmail.com";
    var urlImage = "assets/images/";
    return Drawer(
      child: Material(
        color: colorScheme.purpleMuch,
        child: ListView(
          padding: EdgeInsets.only(left: 20),
          children: <Widget>[
            buildHeader(urlImage = urlImage,
                name: name,
                email: email,
                //add
                onClicked: () => Get.toNamed("/landlordProfile")),
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
            buildMenuItem(text: 'Logout', icon: Icons.logout),
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
        // Get.toNamed("/landlordAppointments");
        break;
      case 2:
        //  Get.toNamed("/landlordTenantsList");
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
                backgroundImage: AssetImage("assets/images/origlogo.png"),
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
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              )
            ],
          ),
        )),
      );
}
