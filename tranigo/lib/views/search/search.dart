import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tranigo/models/pick_up_location.dart';
import 'package:tranigo/services/transfer/pick_up_location_api.dart';
import 'package:tranigo/services/user_api.dart';

class NetworkTypeAheadPage extends StatelessWidget {
  const NetworkTypeAheadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TypeAheadField<Children?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Search Username',
                    ),
                  ),
                  suggestionsCallback:
                      PickUpLocationApi.getPickUpLocationChildren,
                  itemBuilder: (context, Children? suggestion) {
                    final pickUpLocation = suggestion!;

                    return ListTile(
                      leading: Icon(
                        pickUpLocation.type == 1
                            ? Icons.airplanemode_on_outlined
                            : Icons.location_on_outlined,
                        color: Colors.red[400],
                      ),
                      title: Text(pickUpLocation.text!),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Users Found.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (Children? suggestion) {
                    final pickUpLocation = suggestion!;

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Selected user: ${pickUpLocation.text}'),
                      ));
                  },
                ),
                TypeAheadField<User?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Search Username',
                    ),
                  ),
                  suggestionsCallback: UserApi.getUserSuggestions,
                  itemBuilder: (context, User? suggestion) {
                    final user = suggestion!;

                    return ListTile(
                      title: Text(user.name),
                    );
                  },
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Users Found.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (User? suggestion) {
                    final user = suggestion!;

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Selected user: ${user.name}'),
                      ));
                  },
                )
              ])),
        ),
      );
}
