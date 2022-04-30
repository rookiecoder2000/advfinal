import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';

class TenantMainScreen extends StatefulWidget {
  TenantMainScreen({Key? key}) : super(key: key);

  @override
  State<TenantMainScreen> createState() => _TenantMainScreenState();
}

class _TenantMainScreenState extends State<TenantMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Tenant"),
            ElevatedButton(
                onPressed: () {
                  //
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
                child: Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
