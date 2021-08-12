import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthly/constant.dart';
import 'package:flutter/material.dart';
import 'package:healthly/chat.dart';
import 'package:healthly/const.dart';
import 'package:healthly/models/userChatModel.dart';
import 'package:healthly/settings.dart';
import 'package:healthly/widgets/loading.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:healthly/welcomeScreen/welcomeScreen.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;

  ChatScreen({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => ChatScreenState(currentUserId: currentUserId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.currentUserId});

  final String currentUserId;

  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Settings', icon: Icons.settings),
  ];

  @override
  void initState() {
    super.initState();

    listScrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Doctors in Lucknow',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          // List
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .limit(_limit)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) {
                      int c = 0;
                      UserChat userChat =
                          UserChat.fromDocument(snapshot.data?.docs[index]);
                      if (userChat.id !=
                          FirebaseAuth.instance.currentUser.uid) {
                        c = 1;
                        return buildItem(context, snapshot.data?.docs[index]);
                      } else {
                        c = -1;
                      }
                      if (c == 0) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5),
                              Text(
                                "No doctors available",
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "QuickSand",
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                    itemCount: snapshot.data.docs.length,
                    controller: listScrollController,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  );
                }
              },
            ),
          ),

          Positioned(
            child: isLoading ? const Loading() : Container(),
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document != null) {
      UserChat userChat = UserChat.fromDocument(document);
      if (userChat.id == currentUserId) {
        return SizedBox.shrink();
      } else {
        // return Container(
        //   child: TextButton(
        //     child: Row(
        //       children: <Widget>[
        //         Material(
        //           child: userChat.photoUrl.isNotEmpty
        //               ? Image.network(
        //                   userChat.photoUrl,
        //                   fit: BoxFit.cover,
        //                   width: 50.0,
        //                   height: 50.0,
        //                   loadingBuilder: (BuildContext context, Widget child,
        //                       ImageChunkEvent loadingProgress) {
        //                     if (loadingProgress == null) return child;
        //                     return Container(
        //                       width: 50,
        //                       height: 50,
        //                       child: Center(
        //                         child: CircularProgressIndicator(
        //                           color: primaryColor,
        //                           value: loadingProgress.expectedTotalBytes !=
        //                                       null &&
        //                                   loadingProgress.expectedTotalBytes !=
        //                                       null
        //                               ? loadingProgress.cumulativeBytesLoaded /
        //                                   loadingProgress.expectedTotalBytes
        //                               : null,
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                   errorBuilder: (context, object, stackTrace) {
        //                     return Icon(
        //                       Icons.account_circle,
        //                       size: 50.0,
        //                       color: greyColor,
        //                     );
        //                   },
        //                 )
        //               : Icon(
        //                   Icons.account_circle,
        //                   size: 50.0,
        //                   color: greyColor,
        //                 ),
        //           borderRadius: BorderRadius.all(Radius.circular(25.0)),
        //           clipBehavior: Clip.hardEdge,
        //         ),
        //         Flexible(
        //           child: Container(
        //             child: Column(
        //               children: <Widget>[
        //                 Container(
        //                   child: Text(
        //                     'Name: ${userChat.userName}',
        //                     maxLines: 1,
        //                     style: TextStyle(color: primaryColor),
        //                   ),
        //                   alignment: Alignment.centerLeft,
        //                   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
        //                 ),
        //                 Container(
        //                   child: Text(
        //                     'Speciality: ${userChat.speciality}',
        //                     maxLines: 1,
        //                     style: TextStyle(color: primaryColor),
        //                   ),
        //                   alignment: Alignment.centerLeft,
        //                   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        //                 )
        //               ],
        //             ),
        //             margin: EdgeInsets.only(left: 20.0),
        //           ),
        //         ),
        //       ],
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => Chat(
        //             peerName: userChat.userName,
        //             peerId: userChat.id,
        //             peerAvatar: userChat.photoUrl,
        //           ),
        //         ),
        //       );
        //     },
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(greyColor2),
        //       shape: MaterialStateProperty.all<OutlinedBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(10)),
        //         ),
        //       ),
        //     ),
        //   ),
        //   margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
        // );
        colors.shuffle();

        return Container(
            margin: EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
            child: DoctorCard(userChat, colors[0]));
      }
    } else {
      return SizedBox.shrink();
    }
  }
}

List colors = [
  kOrangeColor,
  kBlueColor,
  kYellowColor,
];

class Choice {
  const Choice({@required this.title, @required this.icon});

  final String title;
  final IconData icon;
}

class DoctorCard extends StatelessWidget {
  UserChat userChat;
  Color _bgColor;

  DoctorCard(this.userChat, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chat(
              peerName: userChat.userName,
              peerId: userChat.id,
              peerAvatar: userChat.photoUrl,
            ),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Material(
              child: userChat.photoUrl.isNotEmpty
                  ? Image.network(
                      userChat.photoUrl,
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                              value: loadingProgress.expectedTotalBytes !=
                                          null &&
                                      loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: greyColor,
                        );
                      },
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 50.0,
                      color: greyColor,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            title: Text(
              userChat.userName,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              userChat.speciality,
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
