import 'package:flutter/material.dart';

import '../section/home_data_chart.dart';
import '../section/top_country_list.dart';

import '../widgets/dial_select_button_bar.dart';
import '../widgets/top_country_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDialIndex;

  @override
  void initState() {
    super.initState();
    selectedDialIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Covid-19 Data",
                    style: TextStyle(
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              HomeDataChart(
                selectedDialIndex: selectedDialIndex,
              ),
              DialSelectButtonBar(
                  selectedButtonIndex: selectedDialIndex,
                  onTap: (int i) {
                    setState(() {
                      selectedDialIndex = i;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TopCountryBar(),
              ),
              TopCountryList(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
