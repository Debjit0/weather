import 'dart:io';

import '../model/weather_data.dart';
import 'package:http/http.dart';

class FetchWeatherAPI{
  WeatherData? weatherData;

  //processing data from response to json
  Future<WeatherData> processData(lat,lon)async{
    var response = await http.get
  }
}