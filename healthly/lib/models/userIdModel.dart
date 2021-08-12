import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserIDModel {
  final String userName;

  final String uid;

  final String consultantFor;
  final String photoUrl;

  final String email;

  final String cityName;

  final String phoneNumber;

  Timestamp dateAndTime;

  UserIDModel({
    @required this.userName,
    @required this.uid,
    @required this.consultantFor,
    @required this.email,
    @required this.cityName,
    @required this.photoUrl,
    @required this.phoneNumber,
  });

  UserIDModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        cityName = json['cityName'],
        uid = json['uid'],
        consultantFor = json['consultantFor'],
        email = json['email'],
        photoUrl = json['photoUrl'],
        phoneNumber = json['phoneNumber'],
        dateAndTime = json['dateAndTime'];

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'cityName': cityName,
        'photoUrl': photoUrl,
        'userName': userName,
        'consultantFor': consultantFor,
        'uid': uid,
        'dateAndTime': Timestamp.now(),
        'email': email,
      };
}
