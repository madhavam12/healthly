import 'package:flutter/material.dart';

import 'package:healthly/services/covid19API.dart';

class StatsGrid extends StatelessWidget {
  final CovidData data;

  const StatsGrid({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Wrap(
              children: <Widget>[
                _buildStatCard(
                    'Total Cases', '${data.totalCases}', Colors.orange),
                _buildStatCard('Deaths', '${data.totalCases}', Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Wrap(
              children: <Widget>[
                _buildStatCard('Recovered', '${data.recovered}', Colors.green),
                _buildStatCard('Active', '${data.active}', Colors.lightBlue),
                _buildStatCard('Critical', '${data.critical}', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
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
}
