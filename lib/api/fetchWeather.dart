import 'dart:convert';
import 'dart:io';

import 'package:weather_app/api/apikey.dart';

import '../model/weather_data.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI{
  WeatherData? weatherData;

  //processing data from response to json
  Future<WeatherData> processData(lat,lon)async{
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    
  }

  String apiURL(var lat, var lon){
    String url;
    url="https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apikey";
    return url;
  }
}