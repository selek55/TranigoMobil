import 'package:flutter/material.dart';
import 'package:tranigo/views/city_region_list.dart';
import 'package:tranigo/views/search/search.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({Key? key}) : super(key: key);

  @override
  HomeTabWidgetState createState() => HomeTabWidgetState();
}

class HomeTabWidgetState extends State<HomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.hiking))
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [NetworkTypeAheadPage(), CityRegionListeWidget()],
        ),
      ),
    );
  }
}
