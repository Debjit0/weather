import 'package:flutter/material.dart';
import 'package:weather_app/controller/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Helper helper = new Helper();
  bool isLoading = true;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    helper.getLocation().then((value) {
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text(
                    latitude.toString(),
                    style: TextStyle(color: Colors.amber),
                  ),
                  Text(
                    longitude.toString(),
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
          );
  }
}
