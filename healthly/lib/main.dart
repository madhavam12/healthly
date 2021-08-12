import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'welcomeScreen/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:healthly/homeScreen/homeScreen.dart';
import 'package:hive/hive.dart';
import 'profileCreation/docProfileCreation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var box = await Hive.openBox('doctorCreationBox');
  var box2 = await Hive.openBox('isDoctor');

  runApp(ProviderScope(
    child: LiquidApp(materialApp: MaterialApp(home: getRoute())),
  ));
}

Widget getRoute() {
  var box = Hive.box('doctorCreationBox');
  var box2 = Hive.box('isDoctor');

  ;
  if (FirebaseAuth.instance.currentUser == null) {
    return WelcomePage();
  }
  if (box.get("isFilled") == false && box2.get("isDoctor") == true) {
    return ProfileCreationView();
  }

  if (box2.get("isDoctor") == false) {
    return HomeScreen();
  }
}
