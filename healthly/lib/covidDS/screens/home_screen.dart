import 'package:flutter/material.dart';
import 'package:healthly/covidDS/config/palette.dart';
import 'package:healthly/covidDS/config/styles.dart';
import 'package:healthly/covidDS/data/data.dart';
import 'package:healthly/covidDS/widgets/widgets.dart';
import 'screens.dart';
import 'package:healthly/services/covid19API.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:healthly/providers/providers.dart' as providers;

class CovidHomeScreen extends StatefulWidget {
  @override
  _CovidHomeScreenState createState() => _CovidHomeScreenState();
}

class _CovidHomeScreenState extends State<CovidHomeScreen> {
  String _country = 'India';

  bool isLoading = false;
  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          CovidAPI api = CovidAPI();

          List<CovidData> data = await api.dataForCountry(country: _country);
          List yesterday = await api.dataForyesterday(country: _country);

          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatsScreen(data: data, graph: yesterday),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 15.0,
              ),
            ],
            gradient: LinearGradient(
              colors: [Color(0xFFAD9FE4), Palette.primaryColor],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/own_test.png'),
              SizedBox(width: 5),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'View Statistics',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Text(
                    //   'Tap here to view the latest statistics',
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 16.0,
                    //   ),
                    // ),

                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        CovidAPI api = CovidAPI();

                        List<CovidData> data =
                            await api.dataForCountry(country: _country);
                        List yesterday =
                            await api.dataForyesterday(country: _country);

                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatsScreen(data: data, graph: yesterday),
                          ),
                        );
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.bar_chart,
                        color: Colors.white,
                      ),
                      label: Text(
                        'View Stats',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: isLoading
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            )
          : CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                _buildHeader(screenHeight),
                _buildYourOwnTest(screenHeight),
                _buildPreventionTips(screenHeight),
              ],
            ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          // color: Palette.primaryColor,

          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CountryDropdown(
                  countries: ['China', 'France', 'India', 'Italy', 'UK', 'USA'],
                  country: _country,
                  onChanged: (val) => setState(() {
                    _country = val;
                    StateController controller =
                        context.read(providers.selectedCountry);
                    controller.state = val;
                    print(controller.state);
                  }),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Having symptoms?',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'If you feel sick with any COVID-19 symptoms, please call or text on the helpline number immediately for help',
                  style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: "QuickSand",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () async {
                        await canLaunch("tel:+91-11-23978046")
                            ? await launch("tel:+91-11-23978046")
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
                        await canLaunch("sms:+91-11-23978046")
                            ? await launch("sms:+91-11-23978046")
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
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Safety Tips',
              style: const TextStyle(
                fontSize: 22.0,
                fontFamily: "QuickSand",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                              fontFamily: "QuickSand",
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
