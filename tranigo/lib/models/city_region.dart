class CityRegionList{
  int id;
  String name;
  bool isAirport;
  int cityId;
  String cityName;
  int mesafe;
  int sirala;
  String link;
  bool fiyatVarMi;

  CityRegionList({required this.id, required this.name,required this.isAirport,required this.cityId,required this.cityName,required this.mesafe,required this.sirala, required this.link, required this.fiyatVarMi});

  factory CityRegionList.fromJson(Map<String,dynamic> item){
    return CityRegionList(
              id: item['id'],
              name: item['Name'],
              isAirport: item['isAirport'],
              cityId: item['cityId'],
              cityName: item['cityName'],
              mesafe: item['mesafe'],
              sirala: item['sirala'],
              link: item['link'],
              fiyatVarMi: item['fiyatVarMi']
          );
  }

}