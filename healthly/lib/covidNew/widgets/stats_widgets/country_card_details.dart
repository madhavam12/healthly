import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/default_country_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cases_progress_bars.dart';
import 'new_case_boxes.dart';

// ignore: must_be_immutable
class CountryCardDetails extends StatefulWidget {
  Color color;
  int totalCases;
  final countryName, countryCode, flagPath, isIncreasing;
  Map<String, dynamic> todayJson, yestJson;

  CountryCardDetails(
      {this.color,
      this.todayJson,
      this.yestJson,
      this.totalCases,
      this.countryName,
      this.countryCode,
      this.flagPath,
      this.isIncreasing});

  @override
  _CountryCardDetailsState createState() => _CountryCardDetailsState();
}

class _CountryCardDetailsState extends State<CountryCardDetails>
    with TickerProviderStateMixin {
  AnimationController _controller1, _controller2;
  Duration textScaleDuration;
  final formatter = new NumberFormat("#,###");
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    textScaleDuration = Duration(milliseconds: 200);
    _controller1 = AnimationController(
        vsync: this,
        duration: textScaleDuration,
        lowerBound: 0.7,
        upperBound: 1);
    _controller2 = AnimationController(
        vsync: this,
        duration: textScaleDuration,
        lowerBound: 0.7,
        upperBound: 1);
    _controller1.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //Today / Yesterday Title
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _controller1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    _controller2.reverse();
                    _controller1.forward();
                  });
                },
                child: AutoSizeText(
                  "Today",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight:
                        selectedIndex == 0 ? FontWeight.w700 : FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize: 22.0,
                  ),
                  maxFontSize: 22,
                ),
              ),
            ),
            SizedBox(width: 5),
            ScaleTransition(
              scale: _controller2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    _controller1.reverse();
                    _controller2.forward();
                  });
                },
                child: AutoSizeText(
                  "Yesterday",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight:
                        selectedIndex == 0 ? FontWeight.w600 : FontWeight.w700,
                    color: Colors.grey[800],
                    fontSize: 22.0,
                  ),
                  maxFontSize: 22,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        //New case boxes
        selectedIndex == 0
            ? NewCaseBoxes(
                color: widget.color,
                affected: widget.todayJson["todayCases"],
                deaths: widget.todayJson["todayDeaths"],
                recovered: widget.todayJson["recovered"] -
                    widget.yestJson["recovered"],
                tested: widget.todayJson["tests"],
                totalCases: widget.todayJson["cases"],
                today: true,
              )
            : NewCaseBoxes(
                color: widget.color,
                affected: widget.yestJson["todayCases"],
                deaths: widget.yestJson["todayDeaths"],
                tested: widget.yestJson["tests"],
                totalCases: widget.todayJson["cases"],
                today: false,
              ),

        SizedBox(height: 25),

        //Total Case Bars
        selectedIndex == 0
            ? CaseBars(
                color: widget.color,
                totalActive: widget.todayJson["active"],
                totalDeaths: widget.todayJson["deaths"],
                totalCases: widget.todayJson["cases"],
                totalRecovered: widget.todayJson["recovered"],
              )
            : CaseBars(
                color: widget.color,
                totalActive: widget.yestJson["active"],
                totalDeaths: widget.yestJson["deaths"],
                totalCases: widget.yestJson["cases"],
                totalRecovered: widget.yestJson["recovered"],
              ),

        Expanded(child: SizedBox(height: 35)),

        //Set as default button
      ],
    );
  }
}
