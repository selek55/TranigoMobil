import 'dart:async';

import 'package:tranigo/models/api_response.dart';
import 'package:tranigo/models/city_region.dart';
import 'package:tranigo/services/city_region_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CityRegionListeWidget extends StatefulWidget {
  const CityRegionListeWidget({Key? key}) : super(key: key);

  @override
  CityRegionListeWidgetState createState() => CityRegionListeWidgetState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class CityRegionListeWidgetState extends State<CityRegionListeWidget> {
  CityRegionService get service => GetIt.I<CityRegionService>();
  late APIResponse<List<CityRegionList>> _apiResponse;
  bool _isLooding = false;

  final _debouncer = Debouncer();
  List<CityRegionList> lists = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  _fetchStudents() async {
    setState(() {
      _isLooding = true;
    });

    _apiResponse = await service.getCityRegionList();

    setState(() {
      _isLooding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLooding) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMessage));
        }

        return Column(children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    lists = _apiResponse.data!
                        .where(
                          (u) => (u.name!.toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Colors.green),
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: ValueKey(lists[index].id),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {},
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.only(left: 16),
                        child: const Align(
                          child: Icon(Icons.delete, color: Colors.white),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.supervised_user_circle,
                          size: 44.0,
                          color: Colors.red[400],
                        ),
                        title: Text(
                          lists[index].name ?? "",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(lists[index].name ?? ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.grey[400],
                              ),
                              onPressed: () {},
                            ),
                            /* IconButton(
                icon: Icon(
                  Icons.content_paste,
                  size: 24.0,
                  color: Colors.green[900],
                ),
                onPressed: () {
                  //   _onDeleteItemPressed(index);
                },
              ),
              */
                          ],
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                  itemCount: lists.length))
        ]);
      },
    );
  }
}
