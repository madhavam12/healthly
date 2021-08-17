import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthly/profileCreation/docProfileCreation.dart';

import 'package:hive/hive.dart';
import 'package:healthly/constant.dart';
import 'package:healthly/Models/userIdModel.dart';
import 'detail_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class DoctorResults extends StatefulWidget {
  final String speciality;

  DoctorResults({
    Key key,
    @required this.speciality,
  }) : super(key: key);

  @override
  _DoctorResultsState createState() => _DoctorResultsState();
}

List colors = [
  kOrangeColor,
  kBlueColor,
  kYellowColor,
];
var box2 = Hive.box('city');
String cityName = box2.get('name');

class _DoctorResultsState extends State<DoctorResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  "${widget.speciality} in $cityName",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "QuickSand",
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map>>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("isDoc", isEqualTo: true)
                      .where("speciality", isEqualTo: widget.speciality)
                      .where("cityName", isEqualTo: cityName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(widget.speciality);
                    print(speciality);
                    print(cityName);

                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              // if (snapshot.data.docs[index].id ==
                              //     FirebaseAuth.instance.currentUser.uid) {
                              //   if (snapshot.data.docs.length == 1) {
                              //     return Center(
                              //       child: Container(
                              //         margin: EdgeInsets.all(20),
                              //         child: Center(
                              //           child: Column(
                              //             children: [
                              //               SizedBox(
                              //                   height: MediaQuery.of(context)
                              //                           .size
                              //                           .height /
                              //                       4),
                              //               Text(
                              //                 "Sorry, no ${widget.speciality} available in your city.",
                              //                 style: TextStyle(
                              //                     color: Colors.orange,
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold,
                              //                     fontFamily: "QuickSand"),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   }
                              //   return Container();
                              // }

                              String name =
                                  snapshot.data.docs[index].data()['name'];
                              String speciality = snapshot.data.docs[index]
                                  .data()['speciality'];
                              String pic =
                                  snapshot.data.docs[index].data()['urlAvatar'];

                              colors.shuffle();
                              return GestureDetector(
                                onTap: () {
                                  print("object");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetailScreen(
                                        name: snapshot.data.docs[index]
                                                    .data()["name"] ==
                                                null
                                            ? ""
                                            : snapshot.data.docs[index]
                                                .data()["name"],
                                        speciality: snapshot.data.docs[index]
                                                    .data()["speciality"] ==
                                                null
                                            ? ""
                                            : snapshot.data.docs[index]
                                                .data()["speciality"],
                                        imageUrl: snapshot.data.docs[index]
                                            .data()["urlAvatar"],
                                        aboutMe: snapshot.data.docs[index]
                                                    .data()["aboutMe"] ==
                                                null
                                            ? ""
                                            : snapshot.data.docs[index]
                                                .data()["aboutMe"],
                                        phoneNumber: snapshot.data.docs[index]
                                                    .data()["phoneNumber"] ==
                                                null
                                            ? ""
                                            : snapshot.data.docs[index]
                                                .data()["phoneNumber"],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 35, left: 10),
                                  child: DoctorCard(
                                    name,
                                    FirebaseAuth.instance.currentUser.uid ==
                                        snapshot.data.docs[index].id,
                                    speciality,
                                    pic,
                                    colors[0],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Container(
                            margin: EdgeInsets.all(25),
                            child: Text(
                              "Sorry, no ${widget.speciality} available in your city.",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "QuickSand"),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(25),
                          child: Text(
                            "Sorry, no data available for your city.",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "QuickSand"),
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  String _name;
  String _description;
  bool isYou;
  String _imageUrl;
  Color _bgColor;

  DoctorCard(
      this._name, this.isYou, this._description, this._imageUrl, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          trailing: isYou
              ? Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'You',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
          leading: Image.network(_imageUrl),
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
    );
  }
}
