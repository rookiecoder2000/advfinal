import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_verse_final/views/forgot_password.dart';
import 'package:rent_verse_final/views/onboarding.dart';
import 'package:rent_verse_final/views/sign_in.dart';
import 'package:rent_verse_final/views/sign_up.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      getPages: [
        GetPage(name: '/forgotpassword', page: () => ForgotPassword()),
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/onboarding', page: () => welcomePage())
      ],
      home: SignInScreen(),
    );
  }
}
