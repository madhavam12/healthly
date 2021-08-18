import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'allWidgets.dart';
import 'package:healthly/covidDS/screens/home_screen.dart';
import 'package:healthly/services/FirebaseAuthService.dart';
import 'AllDoctorsPage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tnCPage.dart';
import 'privacyPolicyPage.dart';
import 'package:healthly/covidNew/screens/updates_page.dart';
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
import 'creditsPage.dart';

final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List catagories = [
  "General Physicians",
  "Eye Specialists",
  "Heart Specialists",
  "Dentists"
];

List catagoryIMG = [
  "assets/images/doctor.png",
  "assets/images/eye.png",
  "assets/images/heart.png",
  "assets/images/dentist.png"
];

List colors = [
  kOrangeColor,
  kBlueColor,
  kYellowColor,
];

class _HomeScreenState extends State<HomeScreen> {
  Widget buildMenu(context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final _state = _endSideMenuKey.currentState;

              if (_state.isOpened)
                _state.closeSideMenu();
              else
                _state.openSideMenu();
            },
            leading:
                Icon(LineAwesomeIcons.home, size: 22.50, color: Colors.black),
            title: Text("Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TNCPage()));
            },
            leading: Icon(LineAwesomeIcons.paperclip,
                size: 22.50, color: Colors.black),
            title: Text("Terms and Conditions",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
            },
            leading:
                Icon(LineAwesomeIcons.file, size: 22.50, color: Colors.black),
            title: Text("Privacy Policy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreditsPage()));
            },
            leading: Icon(LineAwesomeIcons.feather,
                size: 22.50, color: Colors.black),
            title: Text("Credits",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllWidgets(),
                ),
              );
            },
            leading: Icon(LineAwesomeIcons.connect_develop,
                size: 22.50, color: Colors.black),
            title: Text("All Widgets",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'madhavam.shahi.12@gmail.com',
                  queryParameters: {'subject': 'Suggestions / Bug Report'});

              launch(_emailLaunchUri.toString());
            },
            leading:
                Icon(LineAwesomeIcons.phone, size: 22.50, color: Colors.black),
            title: Text("Contact",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'madhavam.shahi.12@gmail.com',
                  queryParameters: {'subject': 'Suggestions / Bug Report'});

              launch(_emailLaunchUri.toString());
            },
            leading:
                Icon(LineAwesomeIcons.bug, size: 22.50, color: Colors.black),
            title: Text("Report a bug",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () async {
              FirebaseAuthService _authService = FirebaseAuthService();
              await _authService.signOut();
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            leading: Icon(LineAwesomeIcons.arrow_left,
                size: 22.50, color: Colors.black),
            title: Text("Log out",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Quicksand",
                )),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  String data = "hello";
  int currentIndex = 0;
  void changeIndex({@required int index}) {
    setState(() {
      currentIndex = index;
    });
  }

  SharedPreferences prefs;

  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);

    Size size = MediaQuery.of(context).size;
    return SideMenu(
      closeIcon: Icon(LineAwesomeIcons.times, color: Colors.black, size: 35),
      key: _endSideMenuKey,
      background: Color(0xFFedeeef),
      type: SideMenuType.slide,
      menu: buildMenu(context),
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Color(0xFFFFFFFF),
          child: DotNavigationBar(
            // itemPadding: EdgeInsets.all(5),
            currentIndex: currentIndex,
            onTap: (index) {
              changeIndex(index: index);

              pageController.jumpToPage(index);
            },
            dotIndicatorColor: Colors.orange,
            items: [
              DotNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.home,
                ),
                selectedColor: Colors.orange,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: Icon(LineAwesomeIcons.newspaper),
                selectedColor: Colors.orange,
              ),

              /// Search
              DotNavigationBarItem(
                icon: Icon((LineAwesomeIcons.list)),
                selectedColor: Colors.orange,
              ),

              /// Profile
              DotNavigationBarItem(
                icon: Icon(LineAwesomeIcons.user_astronaut),
                selectedColor: Colors.orange,
              ),
            ],
          ),
        ),
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // final _state = _endSideMenuKey.currentState;

                                // if (_state.isOpened)
                                //   _state.closeSideMenu();
                                // else
                                //   _state.openSideMenu();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15.0, top: 25),
                                child: GestureDetector(
                                  onTap: () {
                                    final _state = _endSideMenuKey.currentState;

                                    if (_state.isOpened)
                                      _state.closeSideMenu();
                                    else
                                      _state.openSideMenu();
                                  },
                                  child: Icon(LineAwesomeIcons.bars,
                                      color: Colors.black, size: 40),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15.0, top: 25),
                              child: Text(
                                "${DateFormat('EEEE').format(DateTime.now())}, $formatter",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "QuickSand",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height / 9),
                        // _qrService.getQrCode(data: "uhuif "),

                        // QrImage(
                        //   data: getUserDataFromHive(),
                        //   version: QrVersions.auto,
                        //   size: 300.0,

                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(
                                  10.0,
                                ),
                                child: Text(
                                  "Find Doctors: ",
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
                            Container(
                              height: 180,
                              // margin: EdgeInsets.all(15),
                              child: ListView.builder(
                                  itemCount: catagories.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DoctorResults(
                                              speciality: catagories[index]
                                                  .toString()
                                                  .substring(
                                                      0,
                                                      catagories[index]
                                                              .toString()
                                                              .length -
                                                          1),
                                            ),
                                          ),
                                        );
                                      },
                                      child: CatagoryCard(
                                        imgPath: catagoryIMG[index],
                                        name: catagories[index],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Container(
                        //     margin: EdgeInsets.all(
                        //       10.0,
                        //     ),
                        //     child: Text(
                        //       "Doctors:",
                        //       style: TextStyle(
                        //         letterSpacing: 1.5,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: "QuickSand",
                        //         fontSize: 25.0,
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        icon: const Icon(
                                          Icons.dashboard,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          'View',
                                          style: Styles.buttonTextStyle
                                              .copyWith(
                                                  fontFamily: "QuickSand"),
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
                                                bottom: 60,
                                                top: 1,
                                                right: 5,
                                                left: 5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                  color: Colors.white
                                                      .withOpacity(0.9),
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
                                                      BorderRadius.circular(
                                                          30.0),
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
                                                          fontFamily:
                                                              "QuickSand"),
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
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(
                                  10.0,
                                ),
                                child: Text(
                                  "Top Doctors: ",
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
                            Container(
                              height: 180,
                              // margin: EdgeInsets.all(15),
                              child: StreamBuilder<QuerySnapshot<Map>>(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .where('isDoc', isEqualTo: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasData) {
                                      if (snapshot.data.docs.isNotEmpty) {
                                        return ListView.builder(
                                            itemCount:
                                                snapshot.data.docs.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DoctorDetailScreen(
                                                                name: snapshot.data.docs[index].data()[
                                                                            "name"] ==
                                                                        null
                                                                    ? ""
                                                                    : snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"],
                                                                speciality: snapshot.data.docs[index].data()[
                                                                            "speciality"] ==
                                                                        null
                                                                    ? ""
                                                                    : snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()["speciality"],
                                                                imageUrl: snapshot
                                                                        .data
                                                                        .docs[index]
                                                                        .data()[
                                                                    "urlAvatar"],
                                                                aboutMe: snapshot.data.docs[index].data()[
                                                                            "aboutMe"] ==
                                                                        null
                                                                    ? ""
                                                                    : snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()["aboutMe"],
                                                                phoneNumber: snapshot.data.docs[index].data()[
                                                                            "phoneNumber"] ==
                                                                        null
                                                                    ? ""
                                                                    : snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .data()["phoneNumber"],
                                                              )));
                                                },
                                                child: PersonCard(
                                                  imgPath: snapshot
                                                      .data.docs[index]
                                                      .data()["urlAvatar"],
                                                  name: snapshot
                                                      .data.docs[index]
                                                      .data()["name"],
                                                ),
                                              );
                                            });
                                      } else {
                                        return Center(
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Text(
                                              "Sorry, no doctors available in your city.",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "QuickSand"),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return Text(
                                        "Sorry, no data available for your city.",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "QuickSand"),
                                      );
                                    }
                                  }),
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InputPage()));
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.9),
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
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.search,
                                                    color: Colors.black,
                                                  ),
                                                  label: Text(
                                                    'Calculate Now!',
                                                    style: Styles
                                                        .buttonTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "QuickSand"),
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
                                                bottom: 60,
                                                top: 1,
                                                right: 5,
                                                left: 5),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeRoute()));
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
                                color: Colors.deepOrange[400]),
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
                                                bottom: 60,
                                                top: 1,
                                                right: 5,
                                                left: 5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                  color: Colors.white
                                                      .withOpacity(0.9),
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
                                                      BorderRadius.circular(
                                                          30.0),
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
                                                          fontFamily:
                                                              "QuickSand"),
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
            ),

            // prefs != null
            //     ? ChatScreen(currentUserId: prefs.getString('id') ?? "")
            //     : Container(),
            // AllDoctors(),

            UpdatesScreen(isHealth: true),
            AllDoctorsIndia(),
            UserProfileView(),
          ],
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final String name;
  final String imgPath;
  PersonCard({Key key, @required this.name, @required this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 150,
              height: 177,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Image.network(
                    imgPath,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CatagoryCard extends StatelessWidget {
  final String name;
  final String imgPath;
  CatagoryCard({Key key, @required this.name, @required this.imgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 180,
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 110,
              height: 157,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Image.asset(
                    imgPath,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: kTitleTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  String _name;
  String _description;
  String _imageUrl;
  Color _bgColor;

  DoctorCard(this._name, this._description, this._imageUrl, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(_name, _description, _imageUrl),
        //   ),
        // );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
