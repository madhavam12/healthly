// import 'package:flutter/material.dart';

// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:hive/hive.dart';

// import 'package:hive/hive.dart';
// import 'package:healthly/services/FirebaseStorageService.dart';
// import 'package:healthly/Models/userIdModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';


// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:flutter/services.dart';

// import 'package:connection_verify/connection_verify.dart';
// import 'package:healthly/services/FirebaseAuthService.dart';

// import 'package:healthly/services/FirestoreDatabaseService.dart';

// class ProfileCreationView extends StatefulWidget {
//   @override
//   _ProfileCreationViewState createState() => _ProfileCreationViewState();
// }

// class _ProfileCreationViewState extends State<ProfileCreationView> {
//   final FocusNode _nameFocus = FocusNode();

//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   void showInSnackBar(
//       {String value,
//       Color color,
//       int sec = 3,
//       @required BuildContext context}) {
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

//   final TextEditingController _nameController = TextEditingController();


//   final FocusNode _specialityFocus = FocusNode();

//   final TextEditingController _specialityController = TextEditingController();

//   final FocusNode _phoneFocus = FocusNode();

//   final TextEditingController _phoneController = TextEditingController();

 
//   final TextEditingController _emailController = TextEditingController();

//   final FocusNode _emailFocus = FocusNode();

//   File _image;

//   final picker = ImagePicker();

 
 
//   Future getImage() async {
//     final pickedFile = await picker.getImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         showInSnackBar(
//             value: "No image selected",
//             sec: 4,
//             color: Colors.red,
//             context: context);
//       }
//     });
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           key: _scaffoldKey,
//           body: SingleChildScrollView(
//             child: SafeArea(
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Container(
//                         margin: EdgeInsets.all(20),
//                         child: Text(
//                           "Let's setup your profile.",
//                           style: TextStyle(
//                             letterSpacing: 1.5,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "QuickSand",
//                             fontSize: 25.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Container(
//                         margin: EdgeInsets.only(
//                             left: 20, right: 20, top: 10, bottom: 10),
//                         child: Text(
//                           "This is your profile which will be shared to other users when they scan your QR code. Please set it up right now, so that you can easily share your profiles with others later on easily.",
//                           style: TextStyle(
//                             letterSpacing: 1.5,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "QuickSand",
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Center(
//                       child: Stack(
//                         children: [
//                           Container(
//                             // margin: EdgeInsets.only(
//                             //     top: 25.0, left: 15, right: 15, bottom: 15),
//                             padding: EdgeInsets.all(75.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               image: DecorationImage(
//                                 fit: BoxFit.contain,
//                                 image: _image == null
//                                     ? AssetImage('assets/images/illus34.png')
//                                     : FileImage(_image),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   offset: Offset(5, 5),
//                                   blurRadius: 10,
//                                 )
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 10,
//                             right: 75,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 padding: EdgeInsets.all(0),
//                                 onPressed: () async {
//                                   getImage();
//                                 },
//                                 icon: Icon(
//                                   Icons.camera_alt_outlined,
//                                   color: Colors.black,
//                                   size: 25,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     GetTextField(
//                         controller: _nameController,
//                         focusNode: _nameFocus,
//                         iconData: LineAwesomeIcons.user,
//                         labelText: "Name",
//                         hintText: "Write your name"),
//                     GetTextField(
//                         controller: _phoneController,
//                         focusNode: _phoneFocus,
//                         iconData: LineAwesomeIcons.phone,
//                         labelText: "Phone Number",
//                         hintText: "Write your phone number"),
//                     GetTextField(
//                         controller: _specialityController,
//                         focusNode: _specialityFocus,
//                         iconData: LineAwesomeIcons.briefcase,
//                         labelText: "Current position",
//                         hintText:
//                             "eg, Software engineer at Google/ freelancer"),
//                     GetTextField(
//                         controller: _emailController,
//                         focusNode: _emailFocus,
//                         iconData: LineAwesomeIcons.envelope,
//                         labelText: "Email",
//                         hintText: "Write your email id"),
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       child: Text(
//                         "Optionals",
//                         style: TextStyle(
//                           letterSpacing: 1.5,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "QuickSand",
//                           fontSize: 30.0,
//                         ),
//                       ),
//                     ),
                  
                  
//                     SizedBox(height: 10),
//                     Container(
//                       margin: EdgeInsets.only(right: 10, left: 10, top: 10),
//                       child: Text(
//                         "*You can upload your resume on Drive and paste the public link here.",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12.5,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         if (_nameController.text == "" ||
//                             _phoneController.text == "" ||
//                             _specialityController.text == "" ||
//                             _emailController.text == "") {
//                           showInSnackBar(
//                               context: context,
//                               value: "Please fill all the fields",
//                               color: Colors.red);
//                           return 0;
//                         }

//                         if (_phoneController.text.length != 10) {
//                           showInSnackBar(
//                               context: context,
//                               value: "Please enter a valid number",
//                               color: Colors.red);
//                           return 0;
//                         }

//                         if (_image == null) {
//                           showInSnackBar(
//                               context: context,
//                               value: "Please upload an image.",
//                               color: Colors.red);
//                           return 0;
//                         }

//                         openLoadingDialog(context, "Creating");

//                         FirebaseStorageService _firebaseStorageService =
//                          FirebaseStorageService();

//                         var imgUpload = await _firebaseStorageService
//                             .uploadImageAndGetDownloadUrl(
//                           image: _image,
//                           uid: FirebaseAuth.instance.currentUser.uid,
//                         );

//                         if (imgUpload is String) {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           showInSnackBar(
//                               context: context,
//                               value: imgUpload,
//                               color: Colors.red);
//                           return 0;
//                         }
//                         if (await ConnectionVerify.connectionStatus()) {
//                           FirestoreDatabaseService _firestoreService =
//                        FirestoreDatabaseService();

//                           var create =
//                               await _firestoreService.createUserProfile(
//                             userModel: UserIDModel(
// speciality:_specialityController.text,
//                               photoURL: imgUpload[0],
//                               cityName: _cityController.text == ""
//                                   ? "Not Specified"
//                                   : _cityController.text,
                             
//                               userName: _nameController.text,
                            
//                               phoneNumber: _phoneController.text,
//                               email: _emailController.text,
                              
//                               uid: FirebaseAuth.instance.currentUser.uid,
//                             ),
//                           );

//                           if (create is String) {
//                             Navigator.of(context, rootNavigator: true).pop();
//                             showInSnackBar(
//                                 context: context,
//                                 value: create,
//                                 color: Colors.red);
//                             return 0;
//                           } else {
                            
//                             Navigator.of(context, rootNavigator: true).pop();
//   Navigator.pop(context);

//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomeScreen()));
//                           }
//                         } else {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           showInSnackBar(
//                               context: context,
//                               value:
//                                   "No Internet connection. Please connect to the internet and then try again.",
//                               color: Colors.red);
//                           return 0;
//                         }
//                       },
//                       child: Container(
//                         height: 45,
//                         // padding: EdgeInsets.all(20.0),
//                         width: double.infinity,
//                         margin: EdgeInsets.all(20),
//                         child: Center(
//                           child: Text(
//                             "Post",
//                             style: TextStyle(
//                               letterSpacing: .95,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "QuickSand",
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15.0),
//                           ),
//                           color: Colors.blue,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//   }
// }

// // class GetTextField extends StatelessWidget {
// //   final FocusNode focusNode;

// //   final TextEditingController controller;
// //   final String hintText;
// //   final String labelText;
// //   final IconData iconData;
// //   const GetTextField(
// //       {Key key,
// //       @required this.iconData,
// //       @required this.controller,
// //       @required this.hintText,
// //       @required this.labelText,
// //       @required this.focusNode})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: EdgeInsets.only(top: 15.0, left: 20, right: 20),
// //       child: TextField(
// //         focusNode: focusNode,
// //         controller: controller,
// //         textInputAction: TextInputAction.next,
// //         keyboardType: TextInputType.name,
// //         onSubmitted: (String name) {
// //           // _titleFocus.unfocus();
// //           // FocusScope.of(context).requestFocus(_descFocus);
// //         },
// //         style: TextStyle(
// //             fontSize: 17.5, fontWeight: FontWeight.normal, color: Colors.white),
// //         decoration: InputDecoration(
// //           labelStyle: TextStyle(fontSize: 18, color: Colors.white),
// //           hintStyle: TextStyle(
// //             fontSize: 10,
// //             color: Colors.white,
// //           ),
// //           prefixIcon: Icon(
// //             iconData,
// //             color: Colors.white,
// //           ),
// //           filled: true,
// //           labelText: labelText,
// //           hintText: hintText,
// //           fillColor: Color(0xFF1a2228),
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //             borderSide: BorderSide.none,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class GetTextField extends StatelessWidget {
//   final FocusNode focusNode;

//   final TextEditingController controller;
//   final String hintText;
//   final String labelText;
//   final IconData iconData;
//   const GetTextField(
//       {Key key,
//       @required this.iconData,
//       @required this.controller,
//       @required this.hintText,
//       @required this.labelText,
//       @required this.focusNode})
//       : super(key: key);

//   getkeyboardType() {
//     if (labelText == "Phone Number") {
//       return TextInputType.number;
//     } else if (labelText == "Email") {
//       return TextInputType.emailAddress;
//     } else {
//       return TextInputType.name;
//     }
//   }

//   getMaxLength() {
//     if (labelText == "Phone Number") {
//       return 10;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 15.0, left: 20, right: 20),
//       child: TextField(
//         focusNode: focusNode,
//         controller: controller,
//         textInputAction: TextInputAction.next,
//         keyboardType: getkeyboardType(),
//         onSubmitted: (String name) {
//           // _titleFocus.unfocus();
//           // FocusScope.of(context).requestFocus(_descFocus);
//         },
//         maxLength: getMaxLength(),
//         cursorColor: Colors.black,
//         style: TextStyle(
//             fontSize: 17.5, fontWeight: FontWeight.normal, color: Colors.black),
//         decoration: InputDecoration(
//           labelStyle: TextStyle(
//             fontSize: 18,
//             color: Colors.black,
//           ),
//           hintStyle: TextStyle(
//             fontSize: 10,
//             color: Colors.black,
//           ),
//           prefixIcon: Icon(iconData, color: Colors.black),
//           filled: true,
//           labelText: labelText,
//           hintText: hintText,
//           fillColor: Color(0xFFeae9e0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }

// openLoadingDialog(BuildContext context, String text) async {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//             content: Row(children: <Widget>[
//               CircularProgressIndicator(
//                   strokeWidth: 1,
//                   valueColor: AlwaysStoppedAnimation(Colors.black)),
//               Expanded(
//                 child: Text(text),
//               ),
//             ]),
//           ));
// }

// void saveUserDataToHive({@required UserIDModel data}) {
//   // state- 0=created just now using the creation page. 1= had created before, loggin in this time. null=no created
//   var box = Hive.box('userDataBox');
//   String valueMap = json.encode(data.toJson(), toEncodable: (o) {
//     return o.toString();
//   });
// // or
//   // Map valueMap = jsonDecode(value);
//   box.put('data', valueMap);
// }
