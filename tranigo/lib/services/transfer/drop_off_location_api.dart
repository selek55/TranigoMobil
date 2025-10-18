import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tranigo/models/drop_off_location.dart';

class DropOffLocationApi {
  static Future<List<DropOffLocation>> getPickUpLocations(int bolge) async {
    final url = Uri.parse('https://www.tranigo.com/en/booking/GetBolge?bolge=' +
        bolge.toString() +
        '&tarih=2022-3-5');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      return users.map((json) => DropOffLocation.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
