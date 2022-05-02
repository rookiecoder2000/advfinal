import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserVerified extends StatelessWidget {
  const UserVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: Column(
        children: [
          Text("Congrats you are fully verified"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/landlordProfile1');
              },
              child: Text("My Profile"))
        ],
      ),
    );
  }
}
