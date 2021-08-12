// import 'package:flutter/material.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:healthly/homeScreen/homeScreen.dart';
// import 'package:healthly/services/FirebaseAuthService.dart';
// import 'package:connection_verify/connection_verify.dart';
// import 'package:healthly/services/FirestoreDatabaseService.dart';
// import 'widgets/local_widgets.dart';
// import 'package:healthly/phoneAuth/otpScreen.dart';
// import 'package:healthly/phoneAuth/PhoneAuthView.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class LoginView extends StatefulWidget {
//   @override
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   final FocusNode myFocusNodeEmailLogin = FocusNode();

//   final FocusNode myFocusNodePasswordLogin = FocusNode();

//   final FocusNode myFocusNodePassword = FocusNode();

//   final FocusNode myFocusNodeEmail = FocusNode();

//   final FocusNode myFocusNodeName = FocusNode();

//   TextEditingController loginEmailController = new TextEditingController();

//   TextEditingController loginPasswordController = new TextEditingController();
//   TextEditingController forgotPasswordController = new TextEditingController();

//   bool _obscureTextLogin = true;

//   bool _obscureTextSignup = true;

//   bool _obscureTextSignupConfirm = true;

//   TextEditingController signupEmailController = new TextEditingController();

//   TextEditingController signupNameController = new TextEditingController();

//   TextEditingController signupPasswordController = new TextEditingController();

//   TextEditingController signupPhoneNumberController =
//       new TextEditingController();

//   PageController _pageController = PageController();

//   Color left = Colors.black;

//   Color right = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: NotificationListener<OverscrollIndicatorNotification>(
//         // ignore: missing_return
//         onNotification: (overscroll) {
//           overscroll.disallowGlow();
//         },
//         child: SingleChildScrollView(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height >= 775.0
//                 ? MediaQuery.of(context).size.height
//                 : 775.0,
//             decoration: new BoxDecoration(
//               gradient: new LinearGradient(
//                   colors: [
//                     // ThemeColors.loginGradientStart,
//                     // ThemeColors.loginGradientEnd
//                     // Color(0xFFFCF0E3),
//                     // Color(0xFFFCF0E3),
//                     Color(0xFF0047ab),
//                     Color(0xFF4169e1)
//                   ],
//                   begin: const FractionalOffset(0.0, 0.0),
//                   end: const FractionalOffset(1.0, 1.0),
//                   stops: [0.0, 1.0],
//                   tileMode: TileMode.clamp),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 75.0),
//                   child: new Image(
//                     width: 250.0,
//                     height: 191.0,
//                     fit: BoxFit.fill,
//                     image: new AssetImage('assets/images/login2.png'),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: _buildMenuBar(context),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: PageView(
//                     controller: _pageController,
//                     onPageChanged: (i) {
//                       if (i == 0) {
//                         setState(() {
//                           right = Colors.white;
//                           left = Colors.black;
//                         });
//                       } else if (i == 1) {
//                         setState(() {
//                           right = Colors.black;
//                           left = Colors.white;
//                         });
//                       }
//                     },
//                     children: <Widget>[
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: _buildSignIn(context),
//                       ),
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: _buildSignUp(context),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void showInSnackBar({String value, Color color, int sec = 3}) {
//     FocusScope.of(context).requestFocus(new FocusNode());
//     _scaffoldKey.currentState?.removeCurrentSnackBar();
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(
//       content: new Text(
//         value,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: 16.0,
//             fontFamily: "WorkSansSemiBold"),
//       ),
//       backgroundColor: color,
//       duration: Duration(seconds: sec),
//     ));
//   }

//   Widget _buildMenuBar(BuildContext context) {
//     return Container(
//       width: 300.0,
//       height: 50.0,
//       decoration: BoxDecoration(
//         color: Color(0x552B2B2B),
//         borderRadius: BorderRadius.all(Radius.circular(25.0)),
//       ),
//       child: CustomPaint(
//         painter: TabIndicationPainter(pageController: _pageController),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignInButtonPress,
//                 child: Text(
//                   "Existing",
//                   style: TextStyle(
//                       color: left,
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansSemiBold"),
//                 ),
//               ),
//             ),
//             //Container(height: 33.0, width: 1.0, color: Colors.white),
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignUpButtonPress,
//                 child: Text(
//                   "New",
//                   style: TextStyle(
//                       color: right,
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansSemiBold"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   openLoadingDialog(BuildContext context, String text) async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => AlertDialog(
//               content: Row(children: <Widget>[
//                 CircularProgressIndicator(
//                     strokeWidth: 1,
//                     valueColor: AlwaysStoppedAnimation(Colors.black)),
//                 Expanded(
//                   child: Text(text),
//                 ),
//               ]),
//             ));
//   }

// //0=lat,1=long,2=addresssLine

//   Widget _buildSignIn(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 23.0),
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             overflow: Overflow.visible,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 190.0,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeEmailLogin,
//                           controller: loginEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           cursorColor: Colors.black,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.envelope,
//                               color: Colors.black,
//                               size: 22.0,
//                             ),
//                             hintText: "Email Address",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 17.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodePasswordLogin,
//                           controller: loginPasswordController,
//                           obscureText: _obscureTextLogin,
//                           cursorColor: Colors.black,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.lock,
//                               size: 22.0,
//                               color: Colors.black,
//                             ),
//                             hintText: "Password",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 17.0),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleLogin,
//                               child: Icon(
//                                 _obscureTextLogin
//                                     ? LineAwesomeIcons.eye
//                                     : LineAwesomeIcons.eye_slash,
//                                 size: 15.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 170.0),
//                 decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: ThemeColors.loginGradientStart,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                     BoxShadow(
//                       color: ThemeColors.loginGradientEnd,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                   gradient: new LinearGradient(
//                       colors: [
//                         ThemeColors.loginGradientEnd,
//                         ThemeColors.loginGradientStart
//                       ],
//                       begin: const FractionalOffset(0.2, 0.2),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 child: MaterialButton(
//                   highlightColor: Colors.transparent,
//                   splashColor: ThemeColors.loginGradientEnd,
//                   //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 42.0),
//                     child: Text(
//                       "LOGIN",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25.0,
//                           fontFamily: "WorkSansBold"),
//                     ),
//                   ),
//                   onPressed: () async {
//                     if (loginEmailController.text == "" ||
//                         loginPasswordController.text == "") {
//                       showInSnackBar(
//                           value: "Please fill all the fields",
//                           color: Colors.red);
//                       return 0;
//                     }
//                     openLoadingDialog(context, "Logging In");

//                     var authService = FirebaseAuthService();
//                     if (!(await ConnectionVerify.connectionStatus())) {
//                       //when no connection
//                       Navigator.of(context, rootNavigator: true).pop();
//                       showInSnackBar(
//                           value:
//                               "No Internet connection. Please connect to the internet and then try again.",
//                           color: Colors.red);
//                       return 0;
//                     }
//                     // var locPermission = await determinePosition();

//                     // String cityName = await getCityName();

//                     if (await ConnectionVerify.connectionStatus()) {
//                       var user = await authService.handleSignInEmail(
//                         email: loginEmailController.text.trim(),
//                         password: loginPasswordController.text.trim(),
//                       );

//                       if (user is String) {
//                         Navigator.of(context, rootNavigator: true).pop();
//                         showInSnackBar(
//                             value: user.toString(), color: Colors.red);
//                         return 0;
//                       }

//                       bool isEmailVerified = authService.isEmailVerified(user);

//                       if (!isEmailVerified) {
//                         FirebaseAuth.instance.signOut();
//                         Navigator.of(context, rootNavigator: true).pop();
//                         showInSnackBar(
//                             value:
//                                 "Email not verified. Please verify then log in again.",
//                             color: Colors.red);
//                         return 0;
//                       }
// //TODO chk fr data here
//                       FirestoreDatabaseService _firestoreService =
//                           FirestoreDatabaseService();
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HomeScreen()));
//                       // if (await _firestoreService.hasFilledData(
//                       //     docId: user.uid)) {
//                       //   Navigator.of(context, rootNavigator: true).pop();
//                       //   NavigationService _navigationService =
//                       //       locator<NavigationService>();
//                       //   _navigationService.navigateTo(Routes.homeView);
//                       // } else {
//                       //   Navigator.of(context, rootNavigator: true).pop();
//                       //   NavigationService _navigationService =
//                       //       locator<NavigationService>();
//                       //   _navigationService
//                       //       .navigateTo(Routes.profileCreationView);
//                       // }
//                     } else {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       showInSnackBar(
//                           value:
//                               "No Internet connection. Please connect to the internet and then try again.",
//                           color: Colors.red);
//                       return 0;
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//           // Padding(
//           //   padding: EdgeInsets.only(top: 10.0),
//           //   child: FlatButton(
//           //     onPressed: () async {},
//           //     child: Text(
//           //       "Forgot Password?",
//           //       style: TextStyle(
//           //           decoration: TextDecoration.underline,
//           //           color: Colors.white,
//           //           fontSize: 16.0,
//           //           fontFamily: "WorkSansMedium"),
//           //     ),
//           //   ),
//           // ),
//           SizedBox(
//             height: 5.0,
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10.0),
//             child: GestureDetector(
//               onTap: () {
//                 Alert(
//                     context: context,
//                     title: "Reset your Password",
//                     content: Column(
//                       children: <Widget>[
//                         TextField(
//                           keyboardType: TextInputType.name,
//                           controller: forgotPasswordController,
//                           decoration: InputDecoration(
//                             icon: Icon(
//                               LineAwesomeIcons.key,
//                             ),
//                             labelText: 'Enter your email id',
//                           ),
//                         ),
//                       ],
//                     ),
//                     buttons: [
//                       DialogButton(
//                         color: Colors.blue,
//                         onPressed: () async {
//                           Navigator.pop(context);
//                           if (forgotPasswordController.text == "") {
//                             showInSnackBar(
//                                 value: "Enter a valid email.",
//                                 color: Colors.green);
//                             return 0;
//                           }
//                           var authService = FirebaseAuthService();
//                           var user = await authService.sendPasswordResetEmail(
//                               forgotPasswordController.text.trim());

//                           if (user is String) {
//                             showInSnackBar(value: "$user", color: Colors.red);
//                             return 0;
//                           }

//                           showInSnackBar(
//                               value: "Password reset link sent.",
//                               color: Colors.green);
//                         },
//                         child: Text(
//                           "Done",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                       )
//                     ]).show();
//               },
//               child: Text(
//                 "Forgot Password?",
//                 style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: Colors.white,
//                     fontSize: 16.0,
//                     fontFamily: "WorkSansMedium"),
//               ),
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.only(top: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: new LinearGradient(
//                         colors: [
//                           Colors.white10,
//                           Colors.white,
//                         ],
//                         begin: const FractionalOffset(0.0, 0.0),
//                         end: const FractionalOffset(1.0, 1.0),
//                         stops: [0.0, 1.0],
//                         tileMode: TileMode.clamp),
//                   ),
//                   width: 100.0,
//                   height: 1.0,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                   child: Text(
//                     "Or",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.0,
//                         fontFamily: "WorkSansMedium"),
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: new LinearGradient(
//                         colors: [
//                           Colors.white,
//                           Colors.white10,
//                         ],
//                         begin: const FractionalOffset(0.0, 0.0),
//                         end: const FractionalOffset(1.0, 1.0),
//                         stops: [0.0, 1.0],
//                         tileMode: TileMode.clamp),
//                   ),
//                   width: 100.0,
//                   height: 1.0,
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
//                 child: new RaisedButton(
//                     padding: EdgeInsets.only(
//                         top: 3.0, bottom: 3.0, left: 15.0, right: 15),
//                     color: const Color(0xFF4285F4),
//                     onPressed: () async {
//                       if (!(await ConnectionVerify.connectionStatus())) {
//                         showInSnackBar(
//                             value:
//                                 "No Internet connection. Please connect to the internet and then try again.",
//                             color: Colors.red);
//                         return 0;
//                       }

//                       try {
//                         var authService = FirebaseAuthService();

//                         // String cityName = await getCityName();
//                         var check = await authService.signInWithGoogle(context);
//                         if (check is String) {
//                           showInSnackBar(
//                               value: "${check}", color: Colors.red, sec: 8);
//                           return 0;
//                         }

//                         FirestoreDatabaseService _firestoreService =
//                             FirestoreDatabaseService();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomeScreen()));
//                         // if (await _firestoreService.hasFilledData(
//                         //     docId: FirebaseAuth.instance.currentUser.uid)) {
//                         //   // Navigator.of(context, rootNavigator: true).pop();
//                         //   Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //           builder: (context) => HomeScreen()));
//                         // } else {
//                         //   // Navigator.of(context, rootNavigator: true).pop();
//                         //   NavigationService _navigationService =
//                         //       locator<NavigationService>();
//                         //   _navigationService
//                         //       .replaceWith(Routes.profileCreationView);

//                         // }
//                       } catch (e) {
//                         print(e);
//                         if (e is PlatformException) {
//                           String errorMessage =
//                               getErrorMessage(errorCode: e.code);
//                           if (errorMessage != null) {
//                             showInSnackBar(
//                                 value: "${e.message}",
//                                 color: Colors.red,
//                                 sec: 8);
//                             return 0;
//                           }
//                         }

//                         if (e is FirebaseAuthException) {
//                           String errorMessage =
//                               getErrorMessage(errorCode: e.code);
//                           showInSnackBar(
//                               value:
//                                   "$errorMessage. If persists, try signing in with Phone or Email instead.",
//                               color: Colors.red,
//                               sec: 8);
//                           return 0;
//                         }
//                         showInSnackBar(
//                             value:
//                                 "Unknown error occured.If it persists, try signing in with Phone or Email instead.",
//                             color: Colors.red,
//                             sec: 8);
//                       }
//                     },
//                     child: new Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         new Image.asset(
//                           'assets/images/google_logo.png',
//                           height: 48.0,
//                         ),
//                         new Container(
//                             padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                             child: new Text(
//                               "Sign in with Google",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             )),
//                       ],
//                     )),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
//                 child: new RaisedButton(
//                   padding: EdgeInsets.only(
//                       top: 3.0, bottom: 3.0, left: 15.0, right: 15),
//                   color: const Color(0xFF4285F4),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PhoneAuthView()));
//                   },
//                   child: new Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Icon(
//                         LineAwesomeIcons.phone,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                       new Container(
//                           padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                           child: new Text(
//                             "Sign in with phone number",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignUp(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 23.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             overflow: Overflow.clip,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 360.0,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeName,
//                           controller: signupNameController,
//                           keyboardType: TextInputType.text,
//                           cursorColor: Colors.black,
//                           textCapitalization: TextCapitalization.words,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.user,
//                               color: Colors.black,
//                             ),
//                             hintText: "Your name",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeEmail,
//                           cursorColor: Colors.black,
//                           controller: signupEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.envelope,
//                               color: Colors.black,
//                             ),
//                             hintText: "Email Address",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(10),
//                           ],
//                           keyboardType: TextInputType.phone,
//                           focusNode: myFocusNodePassword,
//                           cursorColor: Colors.black,
//                           controller: signupPhoneNumberController,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.phone,
//                               color: Colors.black,
//                             ),
//                             hintText: "Phone Number",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           controller: signupPasswordController,
//                           cursorColor: Colors.black,
//                           obscureText: _obscureTextSignupConfirm,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: Colors.black),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               LineAwesomeIcons.key,
//                               color: Colors.black,
//                             ),
//                             hintText: "Password",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleSignupConfirm,
//                               child: Icon(
//                                 _obscureTextSignupConfirm
//                                     ? LineAwesomeIcons.eye
//                                     : LineAwesomeIcons.eye_slash,
//                                 size: 15.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 340.0),
//                 decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: ThemeColors.loginGradientStart,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                     BoxShadow(
//                       color: ThemeColors.loginGradientEnd,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                   gradient: new LinearGradient(
//                       colors: [
//                         ThemeColors.loginGradientEnd,
//                         ThemeColors.loginGradientStart
//                       ],
//                       begin: const FractionalOffset(0.2, 0.2),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 child: MaterialButton(
//                     highlightColor: Colors.transparent,
//                     splashColor: ThemeColors.loginGradientEnd,
//                     //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 42.0),
//                       child: Text(
//                         "SIGN UP",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25.0,
//                             fontFamily: "WorkSansBold"),
//                       ),
//                     ),
//                     onPressed: () async {
//                       if (signupEmailController.text == "" ||
//                           signupPasswordController.text == "" ||
//                           signupNameController.text == "" ||
//                           signupPhoneNumberController.text == "") {
//                         showInSnackBar(
//                             value: "Please fill all the fields",
//                             color: Colors.red);
//                         return 0;
//                       }

//                       openLoadingDialog(context, "Creating");

//                       var authService = FirebaseAuthService();

//                       if (!(await ConnectionVerify.connectionStatus())) {
//                         //when no connection
//                         Navigator.of(context, rootNavigator: true).pop();
//                         showInSnackBar(
//                             value:
//                                 "No Internet connection. Please connect to the internet and then try again.",
//                             color: Colors.red);
//                         return 0;
//                       }
//                       // var locPermission = await determinePosition();

//                       if (await ConnectionVerify.connectionStatus()) {
//                         var signUp = await authService.handleSignUp(
//                           context: context,
//                           name: signupNameController.text,
//                           email: signupEmailController.text.trim(),
//                           password: signupPasswordController.text.trim(),
//                         );

//                         if (signUp is String) {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           showInSnackBar(value: signUp, color: Colors.red);
//                           return 0;
//                         }

//                         FirestoreDatabaseService _firestoreService =
//                             FirestoreDatabaseService();
// // shahiayu2017@gmail.com

//                         var user = await _firestoreService.createAUser(
//                           user: signUp,
//                           name: signupNameController.text,
//                           phoneNumber: signupPhoneNumberController.text,
//                           email: signupEmailController.text.trim(),
//                         );
//                         if (user is String) {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           showInSnackBar(value: user, color: Colors.red);
//                           return 0;
//                         } else {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           FirebaseAuth.instance.signOut();
//                           showInSnackBar(
//                               sec: 7,
//                               value:
//                                   "Email sent. Please verify your email address and login",
//                               color: Colors.orange);
//                           return 0;
//                         }
//                       } else {
//                         Navigator.of(context, rootNavigator: true).pop();
//                         showInSnackBar(
//                             value:
//                                 "No Internet connection. Please connect to the internet and then try again.",
//                             color: Colors.red);
//                         return 0;
//                       }
//                     }),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _onSignInButtonPress() {
//     _pageController.animateToPage(0,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }

//   void _onSignUpButtonPress() {
//     _pageController?.animateToPage(1,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }

//   void _toggleLogin() {
//     setState(() {
//       _obscureTextLogin = !_obscureTextLogin;
//     });
//   }

//   void _toggleSignup() {
//     setState(() {
//       _obscureTextSignup = !_obscureTextSignup;
//     });
//   }

//   void _toggleSignupConfirm() {
//     setState(() {
//       _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//     });
//   }
// }

// int showedMessage = 0;

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  // ThemeColors.loginGradientStart,
                  // ThemeColors.loginGradientEnd
                  // Color(0xFFFCF0E3),
                  // Color(0xFFFCF0E3),
                  Color(0xFF0047ab),
                  Color(0xFF4169e1)
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(children: [
            Image.asset(
              "assets/images/login2.png",
              height: 400,
            ),
            Text(
              "Login to Continue",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "QuickSand",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}
