import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/Models/userIdModel.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'dart:convert';

class FirestoreDatabaseService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future createAUser({
    @required String name,
    @required String cityName,
    @required String phoneNumber,
    @required bool isDoc,
    @required String email,
    @required String photoURL,
    @required User user,
  }) async {
    await _firestore.collection("users").doc(user.uid).set({
      "name": name,
      "idUser": user.uid,
      "cityName": cityName,
      "isDoc": isDoc,
      "phoneNumber": phoneNumber,
      "urlAvatar": photoURL,
      "email": email,
    }).catchError((e) {
      return e;
    });

    // saveToHive(cityName: cityName);
    return true;
  }

  Future createDoctorProfile({
    @required DocIDModel userModel,
  }) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(userModel.toJson())
        .catchError((e) {
      return e;
    });

    var box = Hive.box('doctorCreationBox');
    var box2 = Hive.box('isDoctor');

    box.put('isFilled', true);

    box2.put("isDoctor", true);

    return true;
  }

  Future<bool> hasFilledData({@required String docId}) async {
    DocumentSnapshot<Map> doc =
        await _firestore.collection("users").doc(docId).get();

    if (doc.data()['phoneNumber'] != null &&
        doc.data()['cityName'] != null &&
        doc.data()['urlAvatar'] != null &&
        doc.data()['name'] != null &&
        doc.data()['isDoc'] != null &&
        doc.data()['idUser'] != null &&
        doc.data()['email'] != null &&
        doc.data()['speciality'] != null) {
      return true;
    } else {
      return false;
    }
  }

  // String getCityNameFromHive() {
  //   var box = Hive.box('cityBox');

  //   var cityName = box.get('cityName');

  //   return cityName;
  // }

  // void saveToHive({@required String cityName}) {
  //   var box = Hive.box('cityBox');

  //   box.put('cityName', cityName);
  // }

  Future deleteARequest({@required String docId}) async {
    await _firestore
        .collection("allRequests")
        .doc(docId)
        .delete()
        .catchError((e) {
      return e;
    });

    return true;
  }

  // Future postRequest({@required RequestModel requestModel}) async {
  //   await _firestore
  //       .collection("allRequests")
  //       .doc()
  //       .set(requestModel.toJson())
  //       .catchError((e) {
  //     return e;
  //   });
  //   return true;
  // }

  // Future editRequest(
  //     {@required RequestModel requestModel, @required String docId}) async {
  //   await _firestore
  //       .collection("allRequests")
  //       .doc(docId)
  //       .set(
  //         requestModel.toJson(),
  //         SetOptions(merge: true),
  //       )
  //       .catchError((e) {
  //     return e;
  //   });
  //   return true;
  // }

  Future phoneNumberExists({@required String uid}) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      return false; //do not create
    } else {
      return true; //create
    }
  }

  Future goolesigninEmailExists({@required String uid}) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      return false; //do not create
    } else {
      return true; //create
    }
  }

  Future<DocumentSnapshot> getCurrentUserDoc({@required String uid}) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .catchError((e) => e);

    return doc;
  }
}
// if (requestModel.requestFor == "Medicine Supply") {
//   await _firestore
//       .collection("medicineSupply")
//       .doc()
//       .set(requestModel.toJson())
//       .catchError((e) {
//     return e;
//   });
// } else if (requestModel.requestFor == "Plasma Donation") {
//   await _firestore
//       .collection("plasmaDonations")
//       .doc()
//       .set(requestModel.toJson())
//       .catchError((e) {
//     return e;
//   });
// } else if (requestModel.requestFor == "Others") {
//   await _firestore
//       .collection("otherRequests")
//       .doc()
//       .set(requestModel.toJson())
//       .catchError((e) {
//     return e;
//   });
// } else if (requestModel.requestFor == "Contact Details") {
//   await _firestore
//       .collection("contactNumbers")
//       .doc()
//       .set(requestModel.toJson())
//       .catchError((e) {
//     return e;
//   });
// }
