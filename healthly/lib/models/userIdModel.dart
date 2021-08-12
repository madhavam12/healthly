import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/utils.dart';

class DocIDModel {
  final String name;

  final String idUser;

  final String speciality;
  final String urlAvatar;

  final String email;

  final String cityName;
  final DateTime lastMessageTime;

  final String phoneNumber;

  Timestamp dateAndTime;

  DocIDModel({
    @required this.name,
    @required this.idUser,
    @required this.lastMessageTime,
    @required this.speciality,
    @required this.email,
    @required this.cityName,
    @required this.urlAvatar,
    @required this.phoneNumber,
  });

  DocIDModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cityName = json['cityName'],
        idUser = json['idUser'],
        lastMessageTime = Utils.toDateTime(json['lastMessageTime']),
        speciality = json['speciality'],
        email = json['email'],
        urlAvatar = json['urlAvatar'],
        phoneNumber = json['phoneNumber'],
        dateAndTime = json['dateAndTime'];

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'cityName': cityName,
        'urlAvatar': urlAvatar,
        'name': name,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'speciality': speciality,
        'idUser': idUser,
        'dateAndTime': Timestamp.now(),
        'email': email,
      };
}
