import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'welcomeScreen/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:healthly/homeScreen/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseAuth.instance.currentUser == null
      ? ProviderScope(
          child: LiquidApp(materialApp: MaterialApp(home: WelcomePage())),
        )
      : ProviderScope(
          child: LiquidApp(materialApp: MaterialApp(home: HomeScreen())),
        ));
}
