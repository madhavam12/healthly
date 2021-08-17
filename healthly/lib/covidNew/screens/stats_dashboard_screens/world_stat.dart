import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../widgets/stats_widgets/animated_bottom_bar.dart';
import '../../models/bottom_bar_item.dart';

import '../../screens/stats_dashboard_screens/global_stat.dart';
import '../../values/default_country_data.dart';
import '../../screens/stats_dashboard_screens/country_list.dart';
import 'package:flutter/material.dart';

import 'package:healthly/covidNew/screens/updates_page.dart';

enum CaseType { ACTIVE, DEATHS, RECOVERED }

class WorldStatScreen extends StatefulWidget {
  @override
  _WorldStatScreenState createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen> {
  PageController _controller;
  int selectedBottomBarIndex = 0;
  List<Widget> pages;
  List<BarItem> barItems;
  Future<bool> future;

  Future<bool> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString('defaultCountry');
    if (jsonString != null) {
      defaultCountry = DefaultCountry().fromJson(json.decode(jsonString));
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    future = loadPreferences();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getScaffoldColor() {
    if (selectedBottomBarIndex == 0)
      return Colors.grey[100];
    else if (selectedBottomBarIndex == 1 || selectedBottomBarIndex == 3)
      return Colors.white;
    return defaultCountry.countryName == null
        ? Colors.white
        : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: getScaffoldColor(),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GlobalStatScreen();
            }
            return Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading",
              ),
            );
          },
        ),
      ),
     
    );
  }
}
