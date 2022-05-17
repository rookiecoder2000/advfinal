import 'package:cloud_firestore/cloud_firestore.dart';

class BoardingHouse {
  final String uid;
  final String photoUrl;
  final String price;
  final String roomNumber;
  final String postId;
  final String email;
  final String unitAddress;

  final String rules;

  BoardingHouse({
    required this.uid,
    required this.photoUrl,
    required this.price,
    required this.roomNumber,
    required this.postId,
    required this.email,
    required this.unitAddress,
    required this.rules,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoUrl": photoUrl,
        "price": price,
        "roomNumber": roomNumber,
        "email": email,
        "unitAddress": unitAddress,
        "rules": rules,
        "isOccupied": "no",
        "visible": "no",
        "tenant": "",
      };
}
