import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pin_put/pin_put.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:healthly/loginScreen/loginPage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healthly/providers/providers.dart' as providers;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/homeScreen/homeScreen.dart';

import 'package:healthly/models/userChatModel.dart';

import 'package:flutter/services.dart';

import 'package:connection_verify/connection_verify.dart';
import 'package:healthly/services/FirebaseAuthService.dart';

import 'package:healthly/services/FirestoreDatabaseService.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String name;
  OTPScreen({@required this.phone, @required this.name});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  void showInSnackBar({String value, Color color, int sec = 3}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldkey.currentState?.removeCurrentSnackBar();
    _scaffoldkey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: sec),
    ));
  }

  SharedPreferences prefs;

  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: const Color.fromRGBO(43, 46, 66, 1)
    //
    color: Color(0xFFFCF0E3),

    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldkey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 5.0, left: 25.0, right: 25.0, bottom: 0),
                    child: Center(
                      child: Text(
                        "Verify your number.",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 23.5,
                          fontFamily: "QuickSand",
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image(
                      image: AssetImage(
                        "assets/images/illus35.png",
                      ),
                      height: 350),
                ),
                Container(
                  // margin: EdgeInsets.all(25.0),
                  child: Center(
                    child: Text(
                      'Enter code sent to +91-${widget.phone}',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 20,
                        fontFamily: "QuickSand",
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.black),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      //   showInLoading();
                      //       await Future.delayed(
                      //         Duration(seconds: 5),
                      //       );
                      //       if (value.user != null) {
                      //         NavigationService _navigationService =
                      //             locator<NavigationService>();
                      //         _navigationService.navigateTo(Routes.homeView);
                      try {
                        showInLoading(
                            color: Colors.blue,
                            value: "Signing in..",
                            context: context);

                        UserCredential user =
                            await FirebaseAuth.instance.signInWithCredential(
                          PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin),
                        );

                        // FirestoreDatabaseService _firestoreService =
                        //     FirestoreDatabaseService();
                        // if (await _firestoreService.phoneNumberExists(
                        //         uid: user.user.uid) ==
                        //     true) {
                        //   var user1 = await _firestoreService.createAUser(
                        //     user: user.user,
                        //     name: widget.name,
                        //     phoneNumber: widget.phone,
                        //     email: "None",
                        //   );
                        StateController controller =
                            context.read(providers.userType);
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('id', isEqualTo: user.user.uid)
                            .get();
                        final List<DocumentSnapshot> documents = result.docs;
                        if (documents.length == 0) {
                          // Update data to server if new user
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.user.uid)
                              .set({
                            'userName': widget.name,
                            'photoUrl': "",
                            "userType": controller.state,
                            'id': user.user.uid,
                            'createdAt': DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            'chattingWith': null
                          });
                          User currentUser;

                          // Write data to local
                          currentUser = user.user;
                          await prefs?.setString('id', currentUser.uid);
                          await prefs?.setString('userName', widget.name);
                          await prefs?.setString(
                              'photoUrl', currentUser.photoURL ?? "");
                        } else {
                          DocumentSnapshot documentSnapshot = documents[0];
                          UserChat userChat =
                              UserChat.fromDocument(documentSnapshot);
                          // Write data to local
                          await prefs?.setString('id', userChat.id);
                          await prefs?.setString('userName', userChat.userName);
                          await prefs?.setString('photoUrl', userChat.photoUrl);
                          await prefs?.setString(
                              'speciality', userChat.speciality);
                        }
                        if (user is String) {
                          _scaffoldkey.currentState?.removeCurrentSnackBar();
                          showInSnackBar(
                              value: user.toString(), color: Colors.red);
                          return 0;
                        } else {
                          FirestoreDatabaseService _firestoreService =
                              FirestoreDatabaseService();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          // if (await _firestoreService.hasFilledData(
                          //     docId: FirebaseAuth.instance.currentUser.uid)) {
                          //   // Navigator.of(context, rootNavigator: true).pop();
                          //  Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen()));
                          // } else {
                          //   // Navigator.of(context, rootNavigator: true).pop();

                          // }

                          return 0;
                        }

// shahiayu2017@gmail.com

                      } catch (e) {
                        if (e is PlatformException) {
                          _scaffoldkey.currentState?.removeCurrentSnackBar();
                          showInSnackBar(
                              value: "${e.message}", color: Colors.red, sec: 8);
                          return 0;
                        }

                        if (e is FirebaseAuthException) {
                          String errorMessage =
                              getErrorMessage(errorCode: e.code);

                          if (e.code == "quota-exceeded") {
                            _scaffoldkey.currentState?.removeCurrentSnackBar();
                            showInSnackBar(
                                value:
                                    "SMS verification is not available right now. Please login with Google or Email instead.",
                                color: Colors.red,
                                sec: 6);
                            return 0;
                          }
                          _scaffoldkey.currentState?.removeCurrentSnackBar();
                          showInSnackBar(
                              value: "$errorMessage",
                              color: Colors.red,
                              sec: 8);
                          return 0;
                        }
                        _scaffoldkey.currentState?.removeCurrentSnackBar();
                        showInSnackBar(
                            value:
                                "Unknown error occured. If persists, try signing in with Google or Email instead.",
                            color: Colors.red,
                            sec: 8);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.white10,
                                Colors.white,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          "Or",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: "WorkSansMedium"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white10,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                  child: new RaisedButton(
                    padding: EdgeInsets.only(
                        top: 3.0, bottom: 3.0, left: 15.0, right: 15),
                    color: const Color(0xFF4285F4),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          LineAwesomeIcons.envelope,
                          size: 40,
                          color: Colors.white,
                        ),
                        new Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: new Text(
                              "Sign in with email instead",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                  child: new RaisedButton(
                      padding: EdgeInsets.only(
                          top: 3.0, bottom: 3.0, left: 15.0, right: 15),
                      color: const Color(0xFF4285F4),
                      onPressed: () async {
                        if (!(await ConnectionVerify.connectionStatus())) {
                          showInSnackBar(
                              value:
                                  "No Internet connection. Please connect to the internet and then try again.",
                              color: Colors.red);
                          return 0;
                        }

                        try {
                          var authService = FirebaseAuthService();

                          var check =
                              await authService.signInWithGoogle(context);

                          if (check is String) {
                            showInSnackBar(
                                value: "${check}", color: Colors.red, sec: 8);
                            return 0;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } catch (e) {
                          if (e is PlatformException) {
                            String errorMessage =
                                getErrorMessage(errorCode: e.code);
                            if (errorMessage != null) {
                              showInSnackBar(
                                  value: "${e.message}",
                                  color: Colors.red,
                                  sec: 8);
                              return 0;
                            }
                          }

                          if (e is FirebaseAuthException) {
                            String errorMessage =
                                getErrorMessage(errorCode: e.code);

                            showInSnackBar(
                                value:
                                    "$errorMessage. If persists, try signing in with Phone or Email instead.",
                                color: Colors.red,
                                sec: 8);
                            return 0;
                          }
                          showInSnackBar(
                              value:
                                  "Unknown error occured.If it persists, try signing in with Phone or Email instead.",
                              color: Colors.red,
                              sec: 8);
                        }
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image.asset(
                            'assets/images/google_logo.png',
                            height: 48.0,
                          ),
                          new Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: new Text(
                                "Sign in with Google",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInLoading({
    @required String value,
    @required Color color,
    @required BuildContext context,
  }) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldkey.currentState?.removeCurrentSnackBar();
    _scaffoldkey.currentState.showSnackBar(new SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "WorkSansSemiBold"),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
      backgroundColor: color,
    ));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}

String getErrorMessage({@required String errorCode}) {
  // source: https://firebase.google.com/docs/reference/js/firebase.auth.Auth
  // source: https://firebase.google.com/docs/auth/admin/errors?hl=en
  switch (errorCode) {
    case 'app-deleted':
      return 'The database was not found.';
    case 'expired-action-code':
      return 'The action code o or link has expired.';
    case 'invalid-action-code':
      return 'The action code is invalid. This can happen if the code is malformed or has already been used. ';
    case 'user-disabled':
      return 'The user corresponding to the supplied credential has been disabled.';
    case 'user-not-found':
      return 'The user does not match any credentials.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'email-already-in-use':
      return 'An account already exists with the email address provided.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'The type of account corresponding to this credential is not yet activated.';
    case 'account-exists-with-different-credential':
      return 'E-mail already associated with another account.';
    case 'auth-domain-config-required':
      return 'The configuration for authentication has not been provided.';
    case 'credential-already-in-use':
      return 'An account already exists for this credential.';
    case 'operation-not-supported-in-this-environment':
      return 'This operation is not supported in the environment being performed. Make sure it must be http or https. ';
    case 'timeout':
      return 'Response time exceeded. The domain may not be authorized to perform operations. ';
    case 'missing-android-pkg-name':
      return 'A package name must be provided to install the Android application.';
    case 'missing-continue-uri':
      return 'The next URL must be provided in the request.';
    case 'missing-ios-bundle-id':
      return 'A package name must be provided to install the iOS application.';
    case 'invalid-continue-uri':
      return 'The next URL provided in the request is invalid.';
    case 'unauthorized-continue-uri':
      return 'The domain of the next URL is not whitelisted.';
    case 'invalid-dynamic-link-domain':
      return 'The dynamic link domain provided is not authorized or configured in the current project.';
    case 'argument-error':
      return 'Check the link configuration for the application.';
    case 'invalid-persistence-type':
      return 'The type specified for data persistence is invalid.';
    case 'unsupported-persistence-type':
      return 'The current environment does not support the type specified for data persistence.';
    case 'invalid-credential':
      return 'The credential has expired or is malformed.';
    case 'wrong-password':
      return 'Incorrect password.';
    case 'invalid-verification-code':
      return 'The credential verification code is not valid.';
    case 'invalid-verification-id':
      return 'The credential verification ID is not valid.';
    case 'custom-token-mismatch':
      return 'The token is different from the default requested.';
    case 'invalid-custom-token':
      return 'The provided token is not valid.';
    case 'captcha-check-failed':
      return 'The reCAPTCHA response token is not valid, has expired, or the domain is not allowed.';
    case 'invalid-phone-number':
      return 'The phone number is in an invalid format (E.164 standard).';
    case 'missing-phone-number':
      return 'The phone number is required.';
    case 'quota-exceeded':
      return 'The SMS quota has been exceeded.';
    case 'canceled-popup-request':
      return 'Only one pop-up window request is allowed at one time.';
    case 'popup-blocked':
      return 'The pop-up window has been blocked by the browser.';
    case 'popup-closed-by-user':
      return 'The pop-up window was closed by the user without completing login to the provider.';
    case 'unauthorized-domain':
      return 'The application domain is not authorized to perform operations.';
    case 'invalid-user-token':
      return 'The current user has not been identified.';
    case 'user-token-expired':
      return 'The current user\'s token has expired.';
    case 'null-user':
      return 'The current user is null.';
    case 'app-not-authorized':
      return 'Unauthorized application to authenticate with the given key.';
    case 'invalid-api-key':
      return 'The supplied API key is invalid.';
    case 'network-request-failed':
      return 'Failed to connect to the network.';
    case 'requires-recent-login':
      return 'The user\'s last access time does not meet the security limit.';
    case 'too-many-requests':
      return 'Requests have been blocked due to unusual activity. Try again after some time. ';
    case 'web-storage-unsupported':
      return 'The browser does not support storage or if the user has disabled this feature.';
    case 'invalid-claims':
      return 'The custom registration attributes are invalid.';
    case 'claims-too-large':
      return 'The request size exceeds the maximum allowed size of 1 Megabyte.';
    case 'id-token-expired':
      return 'The reported token has expired.';
    case 'id-token-revoked':
      return 'The informed token has expired.';
    case 'invalid-argument':
      return 'An invalid argument was given to a method.';
    case 'invalid-creation-time':
      return 'Creation time must be a valid UTC date.';
    case 'invalid-disabled-field':
      return 'The property for disabled user is invalid.';
    case 'invalid-display-name':
      return 'The user name is invalid.';
    case 'invalid-email-verified':
      return 'The email is invalid.';
    case 'invalid-hash-algorithm':
      return 'The HASH algorithm is not compatible encryption.';
    case 'invalid-hash-block-size':
      return 'The HASH block size is not valid.';
    case 'invalid-hash-derived-key-length':
      return 'The size of the HASH-derived key is not valid.';
    case 'invalid-hash-key':
      return 'The HASH key must have a valid byte buffer.';
    case 'invalid-hash-memory-cost':
      return 'The cost of HASH memory is not valid.';
    case 'invalid-hash-parallelization':
      return 'HASH parallel loading is not valid.';
    case 'invalid-hash-rounds':
      return 'HASH rounding is not valid.';
    case 'invalid-hash-salt-separator':
      return 'The HASH generation algorithm SALT separator field must be a valid byte buffer.';
    case 'invalid-id-token':
      return 'The token code entered is not valid.';
    case 'invalid-last-sign-in-time':
      return 'The last login time must be a valid UTC date.';
    case 'invalid-page-token':
      return 'The next URL provided in the request is invalid.';
    case 'invalid-password':
      return 'The password is invalid, it must be at least 6 characters long.';
    case 'invalid-password-hash':
      return 'The password HASH is not valid.';
    case 'invalid-password-salt':
      return 'The password SALT is not valid.';
    case 'invalid-photo-url':
      return 'The user photo URL is invalid.';
    case 'invalid-provider-id':
      return 'The provider identifier is not supported.';
    case 'invalid-session-cookie-duration':
      return 'The duration of the session COOKIE must be a valid number in milliseconds, between 5 minutes and 2 weeks.';
    case 'invalid-uid':
      return 'The provided identifier must be a maximum of 128 characters.';
    case 'invalid-user-import':
      return 'The user record to be imported is not valid.';
    case 'invalid-provider-data':
      return 'The data provider is not valid.';
    case 'maximum-user-count-exceeded':
      return 'The maximum number of users allowed to be imported has been exceeded.';
    case 'missing-hash-algorithm':
      return 'It is necessary to provide the HASH generation algorithm and its parameters to import users.';
    case 'missing-uid':
      return 'An identifier is required for the current operation.';
    case 'reserved-claims':
      return 'One or more custom properties provided used reserved words.';
    case 'session-cookie-revoked':
      return 'The session COOKIE has expired.';
    case 'uid-alread-exists':
      return 'The provided identifier is already in use.';
    case 'email-already-exists':
      return 'The email provided is already in use.';
    case 'phone-number-already-exists':
      return 'The phone provided is already in use.';
    case 'project-not-found':
      return 'No projects were found.';
    case "sign_in_canceled":
      return "Please select one account to continue";
    case 'insufficient-permission':
      return 'The credential used is not allowed to access the requested resource.';
    case 'internal-error':
      return 'The authentication server encountered an unexpected error while trying to process the request.';
    default:
      return null;
  }
}

//0=lat,1=long,2=addresssLine
