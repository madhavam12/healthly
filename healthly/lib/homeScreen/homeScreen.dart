import 'package:flutter/material.dart';

import 'dart:async';
import 'package:healthly/covidDS/screens/home_screen.dart';
import 'package:healthly/services/FirebaseAuthService.dart';
import 'AllDoctorsPage.dart';
import 'package:flutter/services.dart';
import 'package:healthly/covidDS/config/styles.dart';
import 'package:healthly/constant.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:healthly/recipePages/search_screen.dart';
import 'package:healthly/profileCreation/docProfileCreation.dart';
import 'package:healthly/covidDsNew/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:healthly/Models/userIdModel.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// QrService _qrService = locator<QrService>();
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List catagories = [
  "General Physican",
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
              // NavigationService _navigationService =
              //     locator<NavigationService>();
              // _navigationService.navigateTo(Routes.termsAndConditionView);
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
              // NavigationService _navigationService =
              //     locator<NavigationService>();
              // _navigationService.navigateTo(
              //     Routes.privacyPolicyView); //TODO chng date on publishing
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
              // NavigationService _navigationService =
              //     locator<NavigationService>();
              // _navigationService.navigateTo(Routes.creditsView);
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
              // final Uri _emailLaunchUri = Uri(
              //     scheme: 'mailto',
              //     path: 'upsynced@gmail.com',
              //     queryParameters: {'subject': 'Suggestions / Bug Report'});

              // launch(_emailLaunchUri.toString());
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
              // final Uri _emailLaunchUri = Uri(
              //     scheme: 'mailto',
              //     path: 'upsynced@gmail.com',
              //     queryParameters: {'subject': 'Suggestions / Bug Report'});

              // launch(_emailLaunchUri.toString());
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
    Size size = MediaQuery.of(context).size;
    return SideMenu(
      closeIcon: Icon(LineAwesomeIcons.times, color: Colors.black, size: 35),
      key: _endSideMenuKey,
      background: Color(0xFFedeeef),
      type: SideMenuType.slide,
      menu: buildMenu(context),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileCreationView()));
          },
        ),
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
                icon: Icon(LineAwesomeIcons.stethoscope),
                selectedColor: Colors.orange,
              ),

              /// Search
              DotNavigationBarItem(
                icon: Icon((LineAwesomeIcons.facebook_messenger)),
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
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   NavigationService _navigationService =
        //       locator<NavigationService>();
        //   _navigationService.navigateTo(Routes.onboardingView);
        // }),
        //TODO on scanning, save a's id into an array in b's doc. and save b's id into an array in a's doc[main profile doc]. and run array contains any query.

        // backgroundColor: Colors.blue,
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
                            GestureDetector(
                              onTap: () {
                                // pageController.jumpToPage(3);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15.0, top: 25),
                                child: Icon(LineAwesomeIcons.user_astronaut,
                                    size: 40, color: Colors.black),
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
                                    return CatagoryCard(
                                        imgPath: catagoryIMG[index],
                                        name: catagories[index]);
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
                                                "Healthy Receipe Finder",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // prefs != null
            //     ? ChatScreen(currentUserId: prefs.getString('id') ?? "")
            //     : Container(),
            AllDoctorsPage(),
            Container(color: Colors.red),
            Container(color: Colors.yellow),
          ],
        ),
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
