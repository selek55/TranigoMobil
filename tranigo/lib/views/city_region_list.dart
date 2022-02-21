import 'package:tranigo/models/api_response.dart';
import 'package:tranigo/models/city_region.dart';
import 'package:tranigo/services/city_region_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CityRegionListe extends StatefulWidget {
  @override
  _CityRegionListeState createState() => _CityRegionListeState();
}

class _CityRegionListeState extends State<CityRegionListe> {
  CityRegionService get service => GetIt.I<CityRegionService>();
  //List<NoteForListing> notes = [];
  APIResponse<List<CityRegionList>>? _apiResponse;
  bool _isLooding = false;

  @override
  void initState() {
    _fetchStudents();
    super.initState();
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
    return Scaffold(
        appBar: AppBar(title: Text('Öğrenci Listesi')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLooding) {
              return CircularProgressIndicator();
            }

            if (_apiResponse?.error ?? false) {
              return Center(child: Text(_apiResponse!.errorMessage));
            }

            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
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
                      _apiResponse.data[index].name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(_apiResponse.data[index].name),
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
            );
          },
        ));
  }
}
