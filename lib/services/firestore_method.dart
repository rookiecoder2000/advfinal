import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_verse_final/models/boarding_house.dart';
import 'package:rent_verse_final/services/storage_service.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add boarding house unit
  Future<String> addUnit(String price, Uint8List file, String uid,
      String roomNumber, String unitAddress, String rules, String email) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("units", file, true);
      String postId = const Uuid().v1();
      BoardingHouse board = BoardingHouse(
          uid: uid,
          photoUrl: photoUrl,
          price: price,
          roomNumber: roomNumber,
          postId: postId,
          email: email,
          unitAddress: unitAddress,
          rules: rules);
      _firestore.collection('units').doc(postId).set(board.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
