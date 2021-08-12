import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CovidAPI {
  Future<List<CovidData>> dataForCountry({@required String country}) async {
    String url =
        'https://corona.lmao.ninja/v2/countries/$country?yesterday&strict&query%20';

    http.Response req = await http.get(Uri.parse(url));

    print(req.body);

    Map data = jsonDecode(req.body);

    String url2 = 'https://disease.sh/v3/covid-19/all?yesterday=yesterday';

    http.Response req2 = await http.get(Uri.parse(url2));

    print(req2.body);

    Map data2 = jsonDecode(req2.body);

    return [
      CovidData(
        active: data['active'],
        critical: data['critical'],
        deaths: data['deaths'],
        recovered: data['recovered'],
        tests: data['tests'],
        todayCases: data['todayCases'],
        totalCases: data['cases'],
        todayDeaths: data['todayDeaths'],
      ),
      CovidData(
        active: data2['active'],
        critical: data2['critical'],
        deaths: data2['deaths'],
        recovered: data2['recovered'],
        tests: data2['tests'],
        todayCases: data2['todayCases'],
        totalCases: data2['cases'],
        todayDeaths: data2['todayDeaths'],
      )
    ];
  }

  Future<List> dataForyesterday({@required String country}) async {
    String url =
        'https://disease.sh/v3/covid-19/historical/$country?lastdays=2';

    http.Response req = await http.get(Uri.parse(url));

    print(req.body);

    Map data = jsonDecode(req.body);

    Map hh = data['timeline']['cases'];
    Map hh2 = data['timeline']['deaths'];
    Map hh3 = data['timeline']['recovered'];

    List cases = [];
    List recovered = [];
    List deaths = [];

    hh.forEach((key, value) {
      cases.add(value);
    });

    hh2.forEach((key, value) {
      deaths.add(value);
    });

    hh3.forEach((key, value) {
      recovered.add(value);
    });

    return [deaths, recovered, cases];
  }
}

String formatDate(String date) {
  int hh = date.length - 2;
//"2012-02-27"
  String j = date.substring(0, hh);
  j += "20";

  String kk2 = j + "21";

  List splitt = kk2.split("/");
  String month = splitt[0].length == 1 ? "0${splitt[0]}" : splitt[0];
  String day = splitt[1].length == 1 ? "0${splitt[1]}" : splitt[1];

  switch (int.parse(month)) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }

  return "${month} ${day}"; // something like 2013-04-20
}

class CovidData {
  int totalCases;
  int todayCases;

  int deaths;

  int todayDeaths;

  int recovered;

  int active;

  int critical;
  int tests;

  CovidData({
    @required this.active,
    @required this.critical,
    @required this.deaths,
    @required this.recovered,
    @required this.tests,
    @required this.todayCases,
    @required this.totalCases,
    @required this.todayDeaths,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      active: json['active'],
      critical: json['critical'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      tests: json['tests'],
      todayCases: json['todayCases'],
      totalCases: json['cases'],
      todayDeaths: json['todayDeaths'],
    );
  }
}
