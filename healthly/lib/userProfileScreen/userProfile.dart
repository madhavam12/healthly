// import 'package:flutter/material.dart';

// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'dart:io';

// import 'package:flutter/services.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:healthly/Models/userIdModel.dart';

// class UserProfileView extends StatefulWidget {
//   @override
//   _UserProfileViewState createState() => _UserProfileViewState();
// }

// class _UserProfileViewState extends State<UserProfileView> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   String formatted3;
//   UserIDModel user = UserIDModel(cityName: "Lucknow", consultantFor: "Physian");
//   // String getUserDataFromHive() {
//   //   var box = Hive.box('userDataBox');

//   //   var data = box.get('data');
//   //   // DateTime dt = DateTime.parse(formattedString);
//   //   DateTime db; //
//   //   Map map = json.decode(data, reviver: (k, v) {
//   //     if (k == 'dateAndTime') {
//   //       //17
//   //       print('$v');
//   //       String sec = "";
//   //       for (int i = 0; i < v.toString().length; i++) {
//   //         if (v.toString()[i] == ",") {
//   //           break;
//   //         }
//   //         if (i >= 18) {
//   //           sec += v.toString()[i];
//   //         }
//   //       }

//   //       String nsec = "";
//   //       for (int i = v.toString().length - 1; i >= 0; i--) {
//   //         if (v.toString()[i] == "=") {
//   //           break;
//   //         } else {
//   //           if (v.toString()[i] != ")") {
//   //             nsec = v.toString()[i] + nsec;
//   //           }
//   //         }
//   //       }

//   //       db = Timestamp.fromDate(
//   //               Timestamp(int.parse(sec), int.parse(nsec)).toDate())
//   //           .toDate();
//   //       return Timestamp.fromDate(
//   //           Timestamp(int.parse(sec), int.parse(nsec)).toDate());
//   //     } else {
//   //       return v; //Return every other object as they are (list, properties...)
//   //     }
//   //   });

//   //   user = UserIDModel.fromJson(map);

//   //   // DateTime db =
//   //   //     Timestamp.fromDate(DateTime.parse(user.dateAndTime.toString()))
//   //   //         .toDate();

//   //   final DateFormat formatter1 = new DateFormat.yMMMMd('en_US');

//   //   formatted3 = formatter1.format(db);
//   //   setState(() {});
//   //   return data;
//   // }

//   @override //TODO create this
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: user == null
//           ? Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.blue,
//               ),
//             )
//           : SingleChildScrollView(
//               child: SafeArea(
//                 child: Container(
//                   margin: EdgeInsets.all(25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 50),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // CircleAvatar(
//                             //   radius: 70,
//                             //   backgroundColor: Colors.white,
//                             //   backgroundImage: AssetImage('assets/images/illus34.png'),
//                             // ),
//                             Container(
//                               // margin: EdgeInsets.only(
//                               //     top: 25.0, left: 15, right: 15, bottom: 15),
//                               padding: EdgeInsets.all(75.0),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                   image: NetworkImage('${user.photoUrl}'),
//                                   fit: BoxFit.contain,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.2),
//                                     offset: Offset(5, 5),
//                                     blurRadius: 10,
//                                   )
//                                 ],
//                               ),
//                             ),

//                             Flexible(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Joined on",
//                                     maxLines: 5,
//                                     style: TextStyle(
//                                       letterSpacing: 1.5,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: "QuickSand",
//                                       fontSize: 25.0,
//                                     ),
//                                   ),
//                                   Text(
//                                     "$formatted3",
//                                     maxLines: 5,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       letterSpacing: 1.5,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: "QuickSand",
//                                       fontSize: 18.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         "${user.userName}",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           letterSpacing: 1.5,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "QuickSand",
//                           fontSize: 35.0,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       OptionRow(
//                         onTap: () {
//                           // NavigationService _navigationService =
//                           //     locator<NavigationService>();
//                           // _navigationService.navigateTo(Routes.editProfileView);
//                         },
//                         iconColor2: Color(0xFFFEF0E4),
//                         text: "Edit Profile",
//                         iconData: LineAwesomeIcons.pencil_ruler,
//                         iconColor: Color(0xFFFE6D1E),
//                       ),
//                       OptionRow(
//                         // TODO for profile edit https://dribbble.com/shots/15054650-BoltCard-Settings-Profile
//                         onTap: () {
//                           // pageController.jumpToPage(1);
//                         },
//                         iconColor2: Color(0xFFECEAFE),
//                         text: "Past Connections",
//                         iconData: LineAwesomeIcons.connect_develop,
//                         iconColor: Color(0xFF5722FB),
//                       ),
//                       OptionRow(
//                         onTap: () {
//                           final Uri _emailLaunchUri = Uri(
//                               scheme: 'mailto',
//                               path: 'upsynced@gmail.com',
//                               queryParameters: {
//                                 'subject': 'Suggestions / Bug Report'
//                               });

//                           // launch(_emailLaunchUri.toString());
//                         },
//                         iconColor2: Color(0xFFE4F7FF),
//                         text: "Contact Us",
//                         iconData: LineAwesomeIcons.envelope,
//                         iconColor: Color(0xFF02A2EE),
//                       ),
//                       OptionRow(
//                         onTap: () async {
//                           // FirebaseAuthService _authService =
//                           //     locator<FirebaseAuthService>();
//                           // await _authService.signOut();
//                           // NavigationService _navigationService =
//                           //     locator<NavigationService>();

//                           // _navigationService.replaceWith(Routes.loginView);
//                         },
//                         iconColor2: Color(0xFFF989A4),
//                         text: "Sign out",
//                         iconData: LineAwesomeIcons.alternate_sign_out,
//                         iconColor: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class OptionRow extends StatelessWidget {
//   final Function onTap;
//   final String text;
//   final IconData iconData;
//   final Color iconColor;
//   final Color iconColor2;
//   OptionRow(
//       {@required this.iconColor,
//       @required this.iconColor2,
//       @required this.onTap,
//       @required this.iconData,
//       @required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 35.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CircleAvatar(
//               backgroundColor: iconColor2,
//               child: Icon(
//                 iconData,
//                 color: iconColor,
//               ),
//             ),
//             Text(
//               text,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 letterSpacing: 1.5,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "QuickSand",
//                 fontSize: 20.0,
//               ),
//             ),
//             CircleAvatar(
//               backgroundColor: Color(0xFFF4F4F6),
//               child: Icon(
//                 LineAwesomeIcons.arrow_right,
//                 color: Color(0xFF3B3C48),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
