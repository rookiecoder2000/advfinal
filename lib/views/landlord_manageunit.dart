import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ManageUnits extends StatefulWidget {
  ManageUnits({Key? key}) : super(key: key);

  @override
  State<ManageUnits> createState() => _ManageUnitsState();
}

class _ManageUnitsState extends State<ManageUnits> {
  final controller = PageController(initialPage: 0);
  bool addClicked = false;
  bool editClicked = false;
  bool removeClicked = false;
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
              })
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Container(
            child: Text("Instructions"),
          ),
          Container(
            child: Text("yawa"),
          ),
          // Container(
          //   child: Text("edit"),
          // ),
          Container(
            child: Text("remove"),
          )
        ],
      ),
    );
  }

  // Widget buildFloatingActionButton() => FloatingActionButton(
  //       backgroundColor: Colors.deepOrange,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //       child: Icon(Icons.settings),
  //       onPressed: () {
  //         //
  //         setState(() {
  //           //
  //         });
  //       },
  //     );
}
