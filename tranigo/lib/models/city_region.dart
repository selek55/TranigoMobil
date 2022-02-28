class CityRegionList {
  int? id;
  String? name;
  bool? isAirport;
  int? cityId;
  String? cityName;
  double? mesafe;
  int? sirala;
  String? link;
  bool? fiyatVarMi;

  CityRegionList(
      {this.id,
      this.name,
      this.isAirport,
      this.cityId,
      this.cityName,
      this.mesafe,
      this.sirala,
      this.link,
      this.fiyatVarMi});

  CityRegionList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isAirport = json['IsAirport'];
    cityId = json['CityId'];
    cityName = json['CityName'];
    mesafe = json['Mesafe'];
    sirala = json['Sirala'];
    link = json['Link'];
    fiyatVarMi = json['FiyatVarMi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['IsAirport'] = isAirport;
    data['CityId'] = cityId;
    data['CityName'] = cityName;
    data['Mesafe'] = mesafe;
    data['Sirala'] = sirala;
    data['Link'] = link;
    data['FiyatVarMi'] = fiyatVarMi;
    return data;
  }
}
