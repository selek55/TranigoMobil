import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tranigo/models/pick_up_location.dart';

class PickUpLocationApi {
  static Future<List<PickUpLocation>> getPickUpLocations(String query) async {
    final url = Uri.parse(
        'https://test.betaindustrial.com.tr/en/booking/search?search=' +
            query.toLowerCase() +
            '&lang=en');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      return users.map((json) => PickUpLocation.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Children>> getPickUpLocationChildren(String query) async {
    final url = Uri.parse(
        'https://test.betaindustrial.com.tr/en/booking/search?search=' +
            query.toLowerCase() +
            '&lang=en');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      final children = <Children>[];

      users
          .map((json) => PickUpLocation.fromJson(json))
          .map((x) => x.children)
          .forEach((x) {
        if (x != null)
          // ignore: curly_braces_in_flow_control_structures
          for (var element in x) {
            children.add(element);
          }
      });

      return children;
    } else {
      throw Exception();
    }
  }
}
