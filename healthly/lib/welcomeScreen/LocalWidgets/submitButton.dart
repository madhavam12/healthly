import 'package:flutter/material.dart';
// import 'package:sample_app/screens/LoginScreen/loginScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthly/loginScreen/loginPage.dart';

import 'package:healthly/providers/providers.dart' as providers;

Widget submitButton({BuildContext context}) {
  return InkWell(
    onTap: () {
      StateController controller = context.read(providers.userType);
      controller.state = "Patient";

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xffdf8e33).withAlpha(100),
                offset: Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2)
          ],
          color: Colors.blue),
      child: Text(
        'Continue as a patient',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontFamily: "QuickSand",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
