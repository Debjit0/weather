import 'package:flutter/material.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/searchpage.dart';

import '../utils/routers.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Details Page",
        style: TextStyle(color: Colors.white),
      )),
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
                      IconButton(onPressed: (){nextPageOnly(context: context, page: LocationPage());}, icon: Icon(Icons.home_rounded, size: 40,)),
                      IconButton(onPressed: (){nextPageOnly(context: context, page: searchPage());}, icon: Icon(Icons.search,size: 40,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.list_rounded,size: 40,color: Colors.blue)),
                    ],),
                  ),
                ),
                
              ),
            ),
    );
  }
}
