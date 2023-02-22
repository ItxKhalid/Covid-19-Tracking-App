import 'dart:convert';

import 'package:covid_19_tracking_app/Services/Utilities/AppUrl.dart';
import 'package:http/http.dart' as http;

import '../Models/WorldStateModel.dart';

class StateServices {
  Future<WorldStateModel> fetchWorldState() async {

    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){

      var data =  jsonDecode(response.body);
      return WorldStateModel.fromJson(data);

    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesListAPI() async {
   var data;
    final response = await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode == 200){

       data = jsonDecode(response.body);
      return data;

    }else{
      throw Exception('Error');
    }
  }
}
