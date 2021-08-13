import 'package:healthly/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthly/covidDS/config/styles.dart';

class DoctorDetailScreen extends StatelessWidget {
  String name;
  String speciality;
  String imageUrl;
  String aboutMe;
  String phoneNumber;

  DoctorDetailScreen(
      {this.name,
      this.phoneNumber,
      this.speciality,
      this.imageUrl,
      this.aboutMe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(imageUrl,
                              height: 120, fit: BoxFit.cover),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kTitleTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                speciality,
                                style: TextStyle(
                                  color: kTitleTextColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/phone.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/chat.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'About Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        aboutMe,
                        style: TextStyle(
                          height: 1.6,
                          color: kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            onPressed: () async {
                              await canLaunch("tel:$phoneNumber")
                                  ? await launch("tel:$phoneNumber")
                                  : throw 'Could not launch';
                            },
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Call Now',
                              style: Styles.buttonTextStyle,
                            ),
                            textColor: Colors.white,
                          ),
                          FlatButton.icon(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            onPressed: () async {
                              await canLaunch("sms:$phoneNumber")
                                  ? await launch("sms:$phoneNumber")
                                  : throw 'Could not launch';
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            icon: const Icon(
                              Icons.chat_bubble,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Send SMS',
                              style: Styles.buttonTextStyle,
                            ),
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
