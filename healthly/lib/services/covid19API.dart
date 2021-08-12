import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

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

  Future<List> dataForlast30Days({@required String country}) async {
    String url =
        'https://disease.sh/v3/covid-19/historical/$country?lastdays=30';

    http.Response req = await http.get(Uri.parse(url));

    print(req.body);

    Map data = jsonDecode(req.body);

    Map hh = data['timeline']['cases'];
    print('hh is $hh');
    List cases = [];
    List date = [];
    hh.forEach((key, value) {
      String formattedDate = formatDate(key);

      date.add(formattedDate);
      String caseInShort = toString(value);
      cases.add(caseInShort);
    });

    return [date, cases];
  }
}

String formatDate(String date) {
  int hh = date.length - 2;

  String j = date.substring(0, hh);
  j += "20";

  String kk = j + "21";
  print("dsasdfdf $kk");
  final DateTime now = DateTime.parse(kk);
  final DateFormat formatter = DateFormat('Md');
  final String formatted = formatter.format(now);
  print(formatted);
  return formatted; // something like 2013-04-20
}

String toString(int value) {
  const units = <int, String>{
    1000000000: 'B',
    1000000: 'M',
    1000: 'K',
  };
  return units.entries
      .map((e) => '${value ~/ e.key}${e.value}')
      .firstWhere((e) => !e.startsWith('0'), orElse: () => '$value');
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
