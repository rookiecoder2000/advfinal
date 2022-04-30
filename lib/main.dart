import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rent_verse_final/services/firebase_auth_methods.dart';
import 'package:rent_verse_final/views/email_verification.dart';
import 'package:rent_verse_final/views/forgot_password.dart';
import 'package:rent_verse_final/views/landlord_main.dart';
import 'package:rent_verse_final/views/loading.dart';

import 'package:rent_verse_final/views/onboarding.dart';
import 'package:rent_verse_final/views/sign_in.dart';
import 'package:rent_verse_final/views/sign_up.dart';
import 'package:rent_verse_final/views/tenant_main.dart';

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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        getPages: [
          GetPage(name: '/forgotpassword', page: () => ForgotPassword()),
          GetPage(name: '/signup', page: () => SignUpPage()),
          GetPage(name: '/signin', page: () => SignInScreen()),
          GetPage(name: '/onboarding', page: () => welcomePage()),
          GetPage(name: '/tenantMain', page: () => TenantMainScreen()),
          GetPage(name: '/landlordMain', page: () => LandLordMainScreen()),
          GetPage(
              name: '/emailverification', page: () => EmailVerificationSent()),
          GetPage(name: '/load', page: () => Load())
        ],
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      if (!firebaseUser.emailVerified) {
        return EmailVerificationSent();
      } else if (firebaseUser.emailVerified) {
        return Load();
      }
    }
    return SignInScreen();
  }
}
