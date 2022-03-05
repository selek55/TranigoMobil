class PickUpLocation {
  String? text;
  List<Children>? children;

  PickUpLocation({this.text, this.children});

  PickUpLocation.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? text;
  int? countryId;
  int? cityId;
  int? type;

  Children({this.id, this.text, this.countryId, this.cityId, this.type});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    countryId = json['countryId'];
    cityId = json['cityId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['countryId'] = countryId;
    data['cityId'] = cityId;
    data['type'] = type;
    return data;
  }
}
