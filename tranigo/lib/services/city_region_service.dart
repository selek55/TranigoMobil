import 'package:tranigo/models/api_response.dart';
import 'package:tranigo/models/city_region.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityRegionService {
  static const api =
      'https://www.tranigo.com/en/booking/GetCityBolge?cityId=1&tarih=2022-01-23';
  static const headers = {'apiKey': '', 'Content-Type': 'application/json'};

  Future<APIResponse<List<CityRegionList>>> getCityRegionList() {
    return http.get(Uri.parse(api), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final students = <CityRegionList>[];

        for (var item in jsonData) {
          students.add(CityRegionList.fromJson(item));
        }

        return APIResponse<List<CityRegionList>>(data: students);
      }
      return APIResponse<List<CityRegionList>>(
          error: true, errorMessage: 'hata olustu.');
    }).catchError((e) => APIResponse<List<CityRegionList>>(
        error: true, errorMessage: 'hata olustu.' + e.toString()));
  }

  //  static List<CityRegionList> parseAgents(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<CityRegionList>((json) => CityRegionList.fromJson(json)).toList();
  // }
}

class ServiceBase {
  static const baseUrl = "";
}
