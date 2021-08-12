import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';

class CovidAPI {
  Future<CovidData> dataForCountry({@required String country}) async {
    String url =
        'https://corona.lmao.ninja/v2/countries/$country?yesterday&strict&query%20';

    http.Response req = await http.get(Uri.parse(url));

    print(req.body);

    Map data = jsonDecode(req.body);
    return CovidData(
      active: data['active'],
      critical: data['critical'],
      deaths: data['deaths'],
      recovered: data['recovered'],
      tests: data['tests'],
      todayCases: data['todayCases'],
      totalCases: data['cases'],
      todayDeaths: data['todayDeaths'],
    );
  }
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
