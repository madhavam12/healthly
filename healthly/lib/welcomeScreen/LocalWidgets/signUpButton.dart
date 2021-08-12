import 'package:flutter/material.dart';
// import 'package:sample_app/screens/SignupScreen/signupScreen.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthly/providers/providers.dart' as providers;

Widget signUpButton(BuildContext context) {
  return InkWell(
    onTap: () {
      StateController controller = context.read(providers.userType);
      controller.state = "Doctor";

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Text(
        'Continue as a doctor',
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontFamily: "QuickSand",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
