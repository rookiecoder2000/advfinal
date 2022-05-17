class LandlordUsers {
  final String uid;
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String city;
  final String postal;
  final String isVerified;
  final String phone;
  final String telephone;
  final String userRole;
  final String email;
  final String address;
  final List tenants;
  final List units;
  final String birthDate;

  LandlordUsers(
      {required this.uid,
      required this.photoUrl,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.gender,
      required this.city,
      required this.postal,
      required this.isVerified,
      required this.phone,
      required this.telephone,
      required this.userRole,
      required this.email,
      required this.address,
      required this.tenants,
      required this.units,
      required this.birthDate});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender,
        "city": city,
        "postalCode": postal,
        "isVerified": isVerified,
        "phone": phone,
        "telephone": telephone,
        "userRole": userRole,
        "email": email,
        "address": address,
        "tenants": tenants,
        "units": units,
        "birthDate": birthDate
      };
}
