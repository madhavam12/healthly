import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserChat {
  String id;
  String photoUrl;
  String userName;
  String speciality;

  UserChat(
      {@required this.id,
      @required this.photoUrl,
      @required this.userName,
      @required this.speciality});

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String speciality = "";
    String photoUrl = "";
    String userName = "";
    try {
      speciality = doc.get('speciality');
    } catch (e) {}
    try {
      photoUrl = doc.get('photoUrl');
    } catch (e) {}
    try {
      userName = doc.get('userName');
    } catch (e) {}
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      userName: userName,
      speciality: speciality,
    );
  }
}
