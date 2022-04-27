import 'package:flutter/material.dart';

class TenantMainScreen extends StatefulWidget {
  TenantMainScreen({Key? key}) : super(key: key);

  @override
  State<TenantMainScreen> createState() => _TenantMainScreenState();
}

class _TenantMainScreenState extends State<TenantMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tenant'),
      ),
    );
  }
}
