import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tranigo/models/drop_off_location.dart';
import 'package:tranigo/models/pick_up_location.dart';
import 'package:tranigo/services/transfer/drop_off_location_api.dart';
import 'package:tranigo/services/transfer/pick_up_location_api.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TransferSearchWidget extends StatefulWidget {
  const TransferSearchWidget({Key? key}) : super(key: key);

  @override
  TransferSearchState createState() => TransferSearchState();
}

class TransferSearchState extends State<TransferSearchWidget> {
  Children? pickUpLocation;
  DropOffLocation? dropOffLocation;

  List<DropOffLocation> dropOffLocationList = [];

  String getPickUpLocationText() {
    return pickUpLocation?.text ?? 'Country, City, Airport or Region';
  }

  String getDropOffLocationText() {
    return dropOffLocation?.name ?? 'Select Location';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TypeAheadField<Children?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        labelText: getPickUpLocationText()),
                  ),
                  suggestionsCallback: (v) =>
                      PickUpLocationApi.getPickUpLocationChildren(v),
                  itemBuilder: (context, Children? suggestion) {
                    final children = suggestion!;

                    return ListTile(
                      leading: Icon(
                        children.type == 1
                            ? Icons.airplanemode_on_outlined
                            : Icons.location_on_outlined,
                        color: Colors.red[400],
                      ),
                      title: Text(children.text!),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Found.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (Children? suggestion) {
                    setState(() {
                      pickUpLocation = suggestion;
                    });

                    DropOffLocationApi.getPickUpLocations(pickUpLocation!.id!)
                        .then((value) => {
                              setState(() {
                                dropOffLocationList = value;
                              })
                            });

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Selected user: ${pickUpLocation!.text}'),
                      ));
                  },
                ),
                TypeAheadField<DropOffLocation?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        labelText: getDropOffLocationText()),
                  ),
                  suggestionsCallback: (value) {
                    // DropOffLocationApi.getPickUpLocations(pickUpLocation!.id!)
                    //     .then((value) => dropOffLocationList = value);

                    // Completer<Iterable<DropOffLocation>> completer =
                    //     Completer();
                    // completer.complete(<String>["cobalt", "copper"]);
                    // return completer.future;

                    return dropOffLocationList;
                  },
                  itemBuilder: (context, DropOffLocation? suggestion) {
                    final children = suggestion!;

                    return ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: Colors.red[400],
                      ),
                      title: Text(children.name!),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Found.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (DropOffLocation? suggestion) {
                    setState(() {
                      dropOffLocation = suggestion;
                    });

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content:
                            Text('Selected user: ${dropOffLocation!.name}'),
                      ));
                  },
                ),
                TextField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(), //DateTime(2018, 3, 5),
                        //maxTime: DateTime(2019, 6, 7),
                        onChanged: (date) {},
                        onConfirm: (date) {},
                        currentTime: DateTime.now());

                    //FocusScopeNode currentFocus = FocusScope.of(context);
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  //focusNode: FirstDisabledFocusNode(),

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),

                TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2019, 6, 7),
                          onChanged: (date) {},
                          onConfirm: (date) {},
                          currentTime: DateTime.now(),
                          locale: LocaleType.tr);
                    },
                    child: const Text(
                      'show date time picker (Tr)',
                      style: TextStyle(color: Colors.blue),
                    ))
                // DropdownButton<DropOffLocation>(
                //   value: dropOffLocation,
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   onChanged: (DropOffLocation? newValue) {
                //     setState(() {
                //       dropOffLocation = newValue!;
                //     });
                //   },
                //   items: dropOffLocationList
                //       .map<DropdownMenuItem<DropOffLocation>>(
                //           (DropOffLocation value) {
                //     return DropdownMenuItem<DropOffLocation>(
                //       value: value,
                //       child: Text(value.name!),
                //     );
                //   }).toList(),
                // ),
              ])),
        ),
      );
}

// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }

class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
