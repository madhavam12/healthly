import 'package:flutter/material.dart';

import 'dart:async';

import 'package:healthly/services/FirebaseAuthService.dart';

import 'package:flutter/services.dart';
import 'package:healthly/constant.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'chatScreen.dart';
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
                                  "Catagories: ",
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(
                              10.0,
                            ),
                            child: Text(
                              "Doctors:",
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
                          height: 700,
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            colors.shuffle();
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 35, left: 10),
                              child: DoctorCard(
                                  'Dr. Stephanie',
                                  'Eye Specialist - Flower Hospitals',
                                  'assets/images/doctor3.png',
                                  colors[0]),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            prefs != null
                ? ChatScreen(currentUserId: prefs.getString('id') ?? "")
                : Container(),
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
