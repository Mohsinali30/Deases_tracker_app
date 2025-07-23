import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:polio_app/Models/worl_states_model.dart';
import 'package:polio_app/Services/Utilites/app_url.dart';
import 'package:polio_app/countries_list.dart';



class StatesServices {

  Future<WorlStatesModel> fecthWorldRecords()async{
    final  response = await http.get(Uri.parse(AppUrl.worldSatesApi));

    if (response.statusCode == 200){
var data = jsonDecode(response.body);
      return  WorlStatesModel.fromJson(data);

    }else{
      throw Exception("Error");


    }
  }

  Future<List<dynamic>> Countrieslist()async{

    final  response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      return  data;

    }else{
      throw Exception("Error");


    }
  }
}
