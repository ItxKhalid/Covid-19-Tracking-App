import 'package:covid_19_tracking_app/Services/state_Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Models/WorldStateModel.dart';
import 'CountryList.dart';


class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Colors.blueAccent,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01 ,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorldState(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap:  {
                          'Total': double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered.toString()),
                          'Deaths': double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        animationDuration: const Duration(seconds: 3),
                        chartType: ChartType.ring,
                        ringStrokeWidth: 18,
                        chartLegendSpacing: 20,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: Column(
                          children: [
                            ReuseRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            ReuseRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            ReuseRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            ReuseRow(title: 'Active', value: snapshot.data!.active.toString()),
                            ReuseRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                            ReuseRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                            ReuseRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const CountryList()));
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15)
                    ),
                          child: const Center(
                            child:  Text(
                              'Track Countries',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  ReuseRow({Key? key, required this.title, required this.value})
      : super(key: key);

  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
