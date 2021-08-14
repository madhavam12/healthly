import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:healthly/covidDS/screens/home_screen.dart';
import 'package:healthly/services/FirebaseAuthService.dart';

import 'package:healthly/userProfileScreen/userProfile.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthly/covidDS/config/styles.dart';

import 'package:healthly/relaxScreen/relaxScreen.dart';

import 'package:healthly/constant.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:healthly/recipePages/search_screen.dart';
import 'package:healthly/profileCreation/docProfileCreation.dart';
import 'package:healthly/covidDsNew/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:healthly/bmiCalculationScreens/input_page/input_page.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:healthly/Models/userIdModel.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// QrService _qrService = locator<QrService>();
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:healthly/homeScreen/allWidgets.dart';
import 'package:flutter/services.dart';

import 'package:healthly/profileCreation/docProfileCreation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/Models/userIdModel.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  DocumentSnapshot<Map> doc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDoc();
  }

  initializeDoc() async {
    doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    setState(() {});
  }

  String formatted3;

  String getDate() {
    Timestamp time = doc.data()['dateAndTime'];
    DateTime db = time.toDate();

    final DateFormat formatter1 = new DateFormat.yMMMMd('en_US');

    formatted3 = formatter1.format(db);
    setState(() {});
    return formatted3;
  }

  @override //TODO create this
  Widget build(BuildContext context) {
    return Scaffold(
      body: doc == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // CircleAvatar(
                            //   radius: 70,
                            //   backgroundColor: Colors.white,
                            //   backgroundImage: AssetImage('assets/images/illus34.png'),
                            // ),
                            Container(
                              // margin: EdgeInsets.only(
                              //     top: 25.0, left: 15, right: 15, bottom: 15),
                              padding: EdgeInsets.all(75.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${doc.data()['urlAvatar']}"),
                                  fit: BoxFit.contain,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                            ),

                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Joined on",
                                    maxLines: 5,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "QuickSand",
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  Text(
                                    "${getDate()}",
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "QuickSand",
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '~ ${doc.data()['speciality']}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      letterSpacing: 1.5,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "QuickSand",
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${doc.data()['name']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "QuickSand",
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      OptionRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileCreationView(),
                            ),
                          );
                          // NavigationService _navigationService =
                          //     locator<NavigationService>();
                          // _navigationService.navigateTo(Routes.editProfileView);
                        },
                        iconColor2: Color(0xFFFEF0E4),
                        text: "Edit Profile",
                        iconData: LineAwesomeIcons.pencil_ruler,
                        iconColor: Color(0xFFFE6D1E),
                      ),
                      OptionRow(
                        // TODO for profile edit https://dribbble.com/shots/15054650-BoltCard-Settings-Profile
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllWidgets(),
                            ),
                          );
                          // pageController.jumpToPage(1);
                        },
                        iconColor2: Color(0xFFECEAFE),
                        text: "View All Widgets",
                        iconData: LineAwesomeIcons.connect_develop,
                        iconColor: Color(0xFF5722FB),
                      ),
                      OptionRow(
                        onTap: () {
                          final Uri _emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'madhavam.shahi.12@gmail.com',
                              queryParameters: {
                                'subject': 'Suggestions / Bug Report'
                              });

                          launch(_emailLaunchUri.toString());
                        },
                        iconColor2: Color(0xFFE4F7FF),
                        text: "Contact Us",
                        iconData: LineAwesomeIcons.envelope,
                        iconColor: Color(0xFF02A2EE),
                      ),
                      OptionRow(
                        onTap: () async {
                          FirebaseAuthService _authService =
                              FirebaseAuthService();
                          await _authService.signOut();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        iconColor2: Color(0xFFF989A4),
                        text: "Sign out",
                        iconData: LineAwesomeIcons.alternate_sign_out,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class OptionRow extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData iconData;
  final Color iconColor;
  final Color iconColor2;
  OptionRow(
      {@required this.iconColor,
      @required this.iconColor2,
      @required this.onTap,
      @required this.iconData,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: iconColor2,
              child: Icon(
                iconData,
                color: iconColor,
              ),
            ),
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                letterSpacing: 1.5,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
                fontSize: 20.0,
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(0xFFF4F4F6),
              child: Icon(
                LineAwesomeIcons.arrow_right,
                color: Color(0xFF3B3C48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
