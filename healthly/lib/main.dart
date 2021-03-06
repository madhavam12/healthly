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
import 'package:flutter/services.dart';
import 'package:connection_verify/connection_verify.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

void main() async {
  StreamSubscription subscription;
  bool _connected;

  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress(
        'google.com'); //Optional method to pass the lookup string
  subscription =
      _simpleConnectionChecker.onConnectionChange.listen((connected) {
    // setState(() {
    //   _connected = connected;
    // });

    if (!connected) {
      Fluttertoast.showToast(
          msg: "No internet connection, please connect to the internet",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var box = await Hive.openBox('doctorCreationBox');
  var box2 = await Hive.openBox('isDoctor');
  var box3 = await Hive.openBox('city');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ProviderScope(
    child: LiquidApp(materialApp: MaterialApp(home: getRoute())),
  ));
}

Widget getRoute() {
  print('here ftyj1');
  var box = Hive.box('doctorCreationBox');
  var box2 = Hive.box('isDoctor');

  ;
  if (FirebaseAuth.instance.currentUser == null) {
    return WelcomePage();
  }

  if (box.get("isFilled") == false && box2.get("isDoctor") == true) {
    print('here 1');
    return ProfileCreationView();
  }

  if (box2.get("isDoctor") == false) {
    print('here 2');
    return HomeScreen();
  }

  if (box.get("isFilled") == true && box2.get("isDoctor") == true) {
    print('here 1');
    return HomeScreen();
  }
}
