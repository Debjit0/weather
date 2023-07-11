import 'package:flutter/material.dart';
import 'package:weather_app/pages/detailspage.dart';
import 'package:weather_app/pages/homepage.dart';

import '../utils/routers.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Search Page",
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
                      IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 40,color: Colors.blue,)),
                      IconButton(onPressed: (){nextPageOnly(context: context, page: DetailsPage());}, icon: Icon(Icons.list_rounded,size: 40)),
                    ],),
                  ),
                ),
                
              ),
            ),
    );
  }
}
