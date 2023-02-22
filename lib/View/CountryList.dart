import 'package:covid_19_tracking_app/Services/state_Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_Screen.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search Country name here',
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.countriesListAPI(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.grey,
                              Color(0xFFF4F4F4),
                              Color(0xFFEBEBF4),
                            ],
                            stops: [
                              0.1,
                              0.3,
                              0.4,
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 85,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ));
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => DetailScreen(
                                  image: snapshot.data![index]
                                  ['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  population: snapshot.data![index]
                                  ['population'],
                                  totalCases: snapshot.data![index]
                                  ['cases'],
                                  totalDeaths: snapshot.data![index]
                                  ['deaths'],
                                  totalRecovered: snapshot.data![index]
                                  ['recovered'],
                                  active: snapshot.data![index]['active'],
                                  todayRecovered: snapshot.data![index]
                                  ['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                  critical: snapshot.data![index]
                                  ['critical'],
                                ));
                                },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => DetailScreen(
                                  image: snapshot.data![index]
                                  ['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  population: snapshot.data![index]
                                  ['population'],
                                  totalCases: snapshot.data![index]
                                  ['cases'],
                                  totalDeaths: snapshot.data![index]
                                  ['deaths'],
                                  totalRecovered: snapshot.data![index]
                                  ['recovered'],
                                  active: snapshot.data![index]['active'],
                                  todayRecovered: snapshot.data![index]
                                  ['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                  critical: snapshot.data![index]
                                  ['critical'],
                                ));
                                },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
