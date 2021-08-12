import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:healthly/constant.dart';

class AllDoctorsPage extends StatefulWidget {
  AllDoctorsPage({Key key}) : super(key: key);

  @override
  _AllDoctorsPageState createState() => _AllDoctorsPageState();
}

List colors = [
  kOrangeColor,
  kBlueColor,
  kYellowColor,
];
var box2 = Hive.box('city');
String cityName = box2.get('name');

class _AllDoctorsPageState extends State<AllDoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  "All doctors in\n$cityName",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "QuickSand",
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                colors.shuffle();
                return Container(
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, right: 35, left: 10),
                  child: DoctorCard(
                    'Dr. Stephanie',
                    'Eye Specialist - Flower Hospitals',
                    'assets/images/doctor3.png',
                    colors[0],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  String _name;
  String _description;
  String _imageUrl;
  Color _bgColor;

  DoctorCard(this._name, this._description, this._imageUrl, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(_name, _description, _imageUrl),
        //   ),
        // );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
