import 'package:firebase_auth/firebase_auth.dart';

class myUsers {
  final String id;
  final String? fullName;
  final String email;
  final String userRole;

  myUsers(
      {required this.id,
      this.fullName,
      required this.email,
      required this.userRole});

  myUsers.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole
    };
  }
}
