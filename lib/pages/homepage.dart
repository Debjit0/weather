import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/api/apikey.dart';
import 'package:weather_app/pages/detailspage.dart';
import 'package:weather_app/pages/searchpage.dart';
import 'package:weather_app/utils/routers.dart';
//import 'package:weather_app/api/fetchWeather.dart';
//import 'package:weather_app/model/weather_data.dart

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddressLocality;
  String? _currentAddressSublocality;
  Position? _currentPosition;
  bool isLoading = true;
  String temp = "0";
  String feelsLike = "0";
  String humidity = "";
  int weatherConditionCode = 0;
  String imageCode = "5";
  String weatherCondition = "Not Found";
  String windSpeed = "";
  String rainLast3Hours = "";
  String sunrise = "";
  String sunset = "";
  //late WeatherData x;
  //final fwa = FetchWeatherAPI();
  fetch() {
    //print("Called Fetch");
    //fwa.processData(_currentPosition!.latitude.toString(),_currentPosition!.longitude.toString());
  }

  

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      //print(_currentPosition!.latitude);
      Placemark place = placemarks[0];
      //print(place);
      setState(() {
        _currentAddressLocality = '${place.locality}';
        _currentAddressSublocality = "${place.subLocality}";
        //print("$_currentAddressLocality-curradd");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  WeatherFactory wf = new WeatherFactory(apikey);
  getWeather() async {
    Weather w = await wf.currentWeatherByLocation(
        _currentPosition!.latitude, _currentPosition!.longitude);
    temp = w.temperature.toString();
    feelsLike = w.tempFeelsLike.toString();
    humidity = w.humidity.toString();
    windSpeed = w.windSpeed.toString();
    weatherConditionCode = int.parse(w.weatherConditionCode.toString());
    weatherCondition = w.weatherDescription.toString();
    weatherCondition = weatherCondition.replaceFirst(weatherCondition[0], weatherCondition[0].toUpperCase());
    sunrise = w.sunrise.toString();
    sunset = w.sunset.toString();
    rainLast3Hours = w.rainLast3Hours.toString();

    print("${w.rainLast3Hours} rain in last 3 hour");
    if (weatherConditionCode >= 801 && weatherConditionCode <= 804) {
      imageCode = "35";
    } else if (weatherConditionCode == 800) {
      imageCode = "26";
    }else if (weatherConditionCode >= 600 && weatherConditionCode <= 622) {
      imageCode = "36";
    } else if (weatherConditionCode >= 500 && weatherConditionCode <= 531) {
      imageCode = "22";
    }else if (weatherConditionCode >= 300 && weatherConditionCode <= 321) {
      imageCode = "5";
    }else if (weatherConditionCode >= 200 && weatherConditionCode <= 231) {
      imageCode = "17";
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition().whenComplete(() {
      getWeather().whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                        children: [
                          Container(
                            height: 250,
                            child: Image.asset("images/yellowblue.png",opacity: const AlwaysStoppedAnimation(.4),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 200,
                                    child: Image.asset("images/12.png"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                  SizedBox(
                    height: 25,
                  ),
                  CupertinoActivityIndicator(
                    radius: 12,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            //appBar: AppBar(title: const Text("Location Page")),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                          (_currentAddressSublocality == "")
                              ? Center(
                                  child: Text(
                                    '${_currentAddressLocality ?? ""}',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ).animate().fade().slide(),
                                )
                              : Center(
                                  child: Text(
                                    '${_currentAddressSublocality ?? ""}',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ).animate().fade().slide(),
                                ),
                        ],
                      ),

                      /*Center(
                        child: Text(
                          '${_currentAddressLocality ?? ""}',
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),*/
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:20),
                            child: Text(
                              "Today's Weather",
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ).animate().fade().slide(),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            child: Image.asset("images/yellowblue.png",opacity: const AlwaysStoppedAnimation(.4),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 200,
                                    child: Image.asset("images/$imageCode.png"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        weatherCondition,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " " + temp.substring(0, 2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 100,
                                color: Colors.white),
                          ),
                          Text(
                            "\u00B0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 100,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 150,
                        //color: Colors.grey,
                        decoration: BoxDecoration(
                      color: Color.fromARGB(255, 24, 26, 34),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(children: [
                            Container(child: Image.asset("images/6.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text("$windSpeed Km/h",style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Wind Speed",style: TextStyle(color: Colors.grey),)
                          ],),
                          Column(children: [
                            Container(child: Image.asset("images/39.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text("$humidity %",style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Chances of Rain",style: TextStyle(color: Colors.grey),)
                          ],),
                          Column(children: [
                            Container(child: Image.asset("images/26.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text(feelsLike.substring(0,2)+ "\u00B0 C",style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Feels Like",style: TextStyle(color: Colors.grey),)
                          ],)
                        ],),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 150,
                        //color: Colors.grey,
                        decoration: BoxDecoration(
                      color: Color.fromARGB(255, 24, 26, 34),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(children: [
                            Container(child: Image.asset("images/26.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text("${sunrise.substring(11,16)}",style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Sunrise",style: TextStyle(color: Colors.grey),)
                          ],),
                          
                          Column(children: [
                            Container(child: Image.asset("images/10.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text("${sunset.substring(11,16)}",style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Feels Like",style: TextStyle(color: Colors.grey),)
                          ],),
                          Column(children: [
                            Container(child: Image.asset("images/39.png"),height: 50,),
                            SizedBox(height: 10,),
                            Text(rainLast3Hours,style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("Last 3 hrs",style: TextStyle(color: Colors.grey),)
                          ],)
                        ],),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 125,
              color: Colors.black,
              //padding: EdgeInsets.all(20),
              child: BottomAppBar(
                color: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 24, 26, 34),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.home_rounded,
                              size: 40,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () {
                              nextPageOnly(
                                  context: context, page: searchPage());
                            },
                            icon: Icon(Icons.search, size: 40)),
                        IconButton(
                            onPressed: () {
                              nextPageOnly(
                                  context: context, page: DetailsPage());
                            },
                            icon: Icon(Icons.list_rounded, size: 40)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
