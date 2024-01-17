import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/Bindings/binding.dart';
import 'package:fyp/Views/MainPage.dart';
import 'package:get/get.dart';

import 'Views/Login.dart';
import 'Widgets/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = '<YOUR STRIPE SECRET PUBLISHABLE KEY HERE>';
  runApp(GetMaterialApp(
    home: FirebaseAuth.instance.currentUser == null
        ? const Login()
        : const MainPage(),
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    initialBinding: defaultBinding(),
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
    defaultTransition: Transition.leftToRightWithFade,
  ));
}


















// pk_test_51InumCJNs8MZJzppfyR24EbzNugzhhMjQuLFFgbPVLFeSm7DUNnuNZfspNa4HaGmssA13mP39eH7EkbgqznSAbCd00AdfaFS6x