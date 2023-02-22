import 'package:covid_19_tracking_app/View/WorldState_Screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      todayRecovered,
      critical,
      test,
      population;

  DetailScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.todayRecovered,
    required this.test,
    required this.critical,
    required this.population,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .10,
                        ),
                        ReuseRow(
                            title: 'Population',
                            value: widget.population.toString()),
                        ReuseRow(
                            title: 'Total',
                            value: widget.totalCases.toString()),
                        ReuseRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReuseRow(
                            title: 'Deaths',
                            value: widget.totalDeaths.toString()),
                        ReuseRow(
                            title: 'Active Cases',
                            value: widget.active.toString()),
                        ReuseRow(
                            title: "Today's Recovered",
                            value: widget.todayRecovered.toString()),
                        ReuseRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ReuseRow(
                            title: 'Tests', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
