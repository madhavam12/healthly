import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:healthly/covidDS/screens/home_screen.dart';
import 'package:healthly/services/FirebaseAuthService.dart';
import 'AllDoctorsPage.dart';

import 'package:healthly/userProfileScreen/userProfile.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthly/covidDS/config/styles.dart';
import 'doctorResults.dart';
import 'package:healthly/relaxScreen/relaxScreen.dart';
import 'detail_screen.dart';
import 'allDoctorsIndia.dart';
import 'package:healthly/constant.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:healthly/recipePages/search_screen.dart';
import 'package:healthly/profileCreation/docProfileCreation.dart';

import 'package:provider/provider.dart';
import 'package:healthly/bmiCalculationScreens/input_page/input_page.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:healthly/Models/userIdModel.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// QrService _qrService = locator<QrService>();
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class AllWidgets extends StatefulWidget {
  AllWidgets({Key key}) : super(key: key);

  @override
  _AllWidgetsState createState() => _AllWidgetsState();
}

class _AllWidgetsState extends State<AllWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(
                      25.0,
                    ),
                    child: Text(
                      "All Widgets",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "QuickSand",
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 25.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/covid.png'),
                    ),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          gradient: new LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.8),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.1, 1.0],
                              tileMode: TileMode.clamp)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                "Covid-19 Information",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "QuickSand",
                                  fontSize: 25.0,
                                ),
                              ),
                              SizedBox(height: 10),
                              FlatButton.icon(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CovidHomeScreen()));
                                },
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                icon: const Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'View',
                                  style: Styles.buttonTextStyle
                                      .copyWith(fontFamily: "QuickSand"),
                                ),
                                textColor: Colors.white,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 25.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/covid.png'),
                      // ),
                      color: Colors.orange.withOpacity(0.89),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 100,
                                    margin: EdgeInsets.only(
                                        bottom: 60, top: 1, right: 5, left: 5),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/food.png"),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Healthy Meal Finder",
                                        style: TextStyle(
                                          letterSpacing: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "QuickSand",
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        "Enter the calories and your diet (Vegan, Gluten Free,etc) and get instant healthly receipes for breakfast, lunch & dinner.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "QuickSand",
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      FlatButton.icon(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchScreen()));
                                        },
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        icon: const Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'Find Now!',
                                          style: Styles.buttonTextStyle
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "QuickSand"),
                                        ),
                                        textColor: Colors.white,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InputPage()));
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 25.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/covid.png'),
                      // ),
                      color: Colors.blue.withOpacity(0.89),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Calculate Your BMI",
                                          style: TextStyle(
                                            letterSpacing: 1.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "QuickSand",
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          "Tap below to calculate your BMI instantly. Always stay healthy!",
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "QuickSand",
                                            fontSize: 11.0,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        FlatButton.icon(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InputPage()));
                                          },
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            'Calculate Now!',
                                            style: Styles.buttonTextStyle
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: "QuickSand"),
                                          ),
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 100,
                                    margin: EdgeInsets.only(
                                        bottom: 60, top: 1, right: 5, left: 5),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/weight.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeRoute()));
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 25.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/covid.png'),
                      // ),
                      color: Colors.amber.withOpacity(0.99),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Center(
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 100,
                                    margin: EdgeInsets.only(
                                        bottom: 60, top: 1, right: 5, left: 5),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/meditate.png"),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Relieve Stress",
                                        style: TextStyle(
                                          letterSpacing: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "QuickSand",
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        "Feeling Stressed? Tap below to listen to some refreshing music from nature.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "QuickSand",
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      FlatButton.icon(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeRoute()));
                                        },
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        icon: Icon(
                                          Icons.music_note,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'Listen',
                                          style: Styles.buttonTextStyle
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "QuickSand"),
                                        ),
                                        textColor: Colors.white,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
