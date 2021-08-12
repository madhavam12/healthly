import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:healthly/covidDS/config/palette.dart';
import 'package:healthly/covidDS/config/styles.dart';
// import 'package:healthly/covidDS/data/data.dart';
import 'package:healthly/covidDS/widgets/widgets.dart';
import 'package:healthly/services/covid19API.dart';

import 'package:riverpod/riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthly/providers/providers.dart' as providers;

class StatsScreen extends StatefulWidget {
  final List<CovidData> data;

  final List graph;

  StatsScreen({this.data, this.graph});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

Container _buildStatCard(String title, String count, MaterialColor color) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

class _StatsScreenState extends State<StatsScreen> {
  String totalCases;
  String deaths;
  String recovered;
  String critical;
  String active;
  Widget buildBox({
    @required BuildContext context,
    @required CovidData data,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Wrap(
              children: <Widget>[
                _buildStatCard('Total Cases', totalCases, Colors.orange),
                _buildStatCard('Deaths', deaths, Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Wrap(
              children: <Widget>[
                _buildStatCard('Recovered', recovered, Colors.green),
                _buildStatCard('Active', active, Colors.lightBlue),
                _buildStatCard('Critical', critical, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CovidData data = widget.data[0];
    totalCases = data.totalCases.toString();
    deaths = data.deaths.toString();
    recovered = data.recovered.toString();
    critical = data.critical.toString();
    active = data.active.toString();
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    StateController controller = context.read(providers.selectedCountry);
    print(controller.state);
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(controller.state),
              Text('Global'),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  int selectedIndex = 0;
  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Total'),
              Text('Today'),
            ],
            onTap: (index) {
              print('here');
              if (index == 1) {
                print('here22');
                setState(() {
                  if (selectedIndex == 0) {
                    totalCases = widget.data[0].todayCases.toString();
                    deaths = widget.data[0].todayDeaths.toString();
                    recovered = widget.data[0].recovered.toString();
                    critical = widget.data[0].critical.toString();
                    active = widget.data[0].active.toString();
                  } else {
                    totalCases = widget.data[1].todayCases.toString();
                    deaths = widget.data[1].todayDeaths.toString();
                    recovered = widget.data[1].recovered.toString();
                    critical = widget.data[1].critical.toString();
                    active = widget.data[1].active.toString();
                  }

                  print(":totalCases1 $totalCases");
                });
              } else if (index == 2) {
                setState(() {
                  if (selectedIndex == 0) {
                    totalCases = widget.graph[2].toString();

                    deaths = widget.graph[0].toString();
                    recovered = widget.graph[1].toString();
                    critical = widget.data[0].critical.toString();
                    active = widget.data[0].active.toString();
                  } else {
                    totalCases = widget.graph[2].toString();

                    deaths = widget.graph[0].toString();
                    recovered = widget.graph[1].toString();
                    critical = widget.data[1].critical.toString();
                    active = widget.data[1].active.toString();
                  }
                });
              } else {
                setState(() {
                  if (selectedIndex == 0) {
                    totalCases = widget.data[0].totalCases.toString();
                    print(":totalCases $totalCases");
                    deaths = widget.data[0].deaths.toString();
                    recovered = widget.data[0].recovered.toString();
                    critical = widget.data[0].critical.toString();
                    active = widget.data[0].active.toString();
                  } else {
                    totalCases = widget.data[1].totalCases.toString();
                    print(":totalCases $totalCases");
                    deaths = widget.data[1].deaths.toString();
                    recovered = widget.data[1].recovered.toString();
                    critical = widget.data[1].critical.toString();
                    active = widget.data[1].active.toString();
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: buildBox(context: context, data: widget.data[0]),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height / 20),
            Image.asset('assets/images/graph.png', height: 150),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Statistics',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
