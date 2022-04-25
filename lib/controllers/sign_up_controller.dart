import 'dart:ui';

import 'package:get/get.dart';

class signUpController extends GetxController {
  //for Progress line
  double lineProgress(int index) {
    var _index = index;
    var _progressValue = 0.3;

    if (_index == 0) {
      _progressValue = 0.3;
    } else if (_index == 1) {
      _progressValue = 0.6;
    } else if (_index == 2) {
      _progressValue = 1.0;
    }
    return _progressValue;
  }

  //for ContainerColor
  String accountType(int containerIndex) {
    var _containerIndex = containerIndex;
    var _accountType;

    if (_containerIndex == 0) {
      _accountType = "Tenant";
    } else if (_containerIndex == 1) {
      _accountType = "Landlord";
    }
    return _accountType;
  }
  //nullChecker for textfields

  bool nullChecker(
      firstname, lastname, contact, address, occupation, position, birthday) {
    var isComplete;

    if (firstname == "" ||
        lastname == "" ||
        contact == "" ||
        address == "" ||
        occupation == "" ||
        position == "" ||
        birthday == "") {
      isComplete = false;
    } else {
      isComplete = true;
    }

    return isComplete;
  }
  //Contact number validator

  //auto capitalize textfield inputs
}
