import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocIDModel {
  final String name;

  final String idUser;

  final String speciality;
  final String urlAvatar;

  final String email;
  final String aboutMe;
  final bool isDoc;
  final String cityName;

  final String phoneNumber;

  Timestamp dateAndTime;

  DocIDModel({
    @required this.name,
    @required this.isDoc,
    @required this.idUser,
    @required this.speciality,
    @required this.email,
    @required this.aboutMe,
    @required this.cityName,
    @required this.urlAvatar,
    @required this.phoneNumber,
  });

  DocIDModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cityName = json['cityName'],
        idUser = json['idUser'],
        isDoc = json['isDoc'],
        speciality = json['speciality'],
        email = json['email'],
        urlAvatar = json['urlAvatar'],
        phoneNumber = json['phoneNumber'],
        aboutMe = json['aboutMe'],
        dateAndTime = json['dateAndTime'];

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'cityName': cityName,
        'urlAvatar': urlAvatar,
        'aboutMe': aboutMe,
        "isDoc": isDoc,
        'name': name,
        'speciality': speciality,
        'idUser': idUser,
        'dateAndTime': Timestamp.now(),
        'email': email,
      };
}
