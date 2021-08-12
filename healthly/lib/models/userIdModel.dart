import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocIDModel {
  final String userName;

  final String uid;

  final String speciality;
  final String photoURL;

  final String email;

  final String cityName;

  final String phoneNumber;

  Timestamp dateAndTime;

  DocIDModel({
    @required this.userName,
    @required this.uid,
    @required this.speciality,
    @required this.email,
    @required this.cityName,
    @required this.photoURL,
    @required this.phoneNumber,
  });

  DocIDModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        cityName = json['cityName'],
        uid = json['uid'],
        speciality = json['speciality'],
        email = json['email'],
        photoURL = json['photoURL'],
        phoneNumber = json['phoneNumber'],
        dateAndTime = json['dateAndTime'];

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'cityName': cityName,
        'photoURL': photoURL,
        'userName': userName,
        'speciality': speciality,
        'uid': uid,
        'dateAndTime': Timestamp.now(),
        'email': email,
      };
}
