import 'package:hmpaisrn/data/agencies.dart';

class Location {
  int id;
  String name;
  String infoURL;
  String wikiURL;
  String countryCode;
  Agencies agencies;
  List<Pads> pads;

  Location(
      {this.id,
      this.name,
      this.wikiURL,
      this.infoURL,
      this.countryCode,
      this.pads});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    wikiURL = json['wikiURL'];
    infoURL = json['infoURL'];
    countryCode = json['countryCode'];
    if (json['agencies'] != null)
      agencies = Agencies.fromJson(json['agencies']);
    if (json['pads'] != null) {
      pads = new List<Pads>();
      json['pads'].forEach((v) {
        pads.add(new Pads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['wikiURL'] = this.wikiURL;
    data['infoURL'] = this.infoURL;
    data['countryCode'] = this.countryCode;
    return data;
  }
}

class Pads {
  int id;
  String name;
  double latitude;
  double longitude;

  Pads({this.id, this.name, this.latitude, this.longitude});

  Pads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'].toDouble();
    longitude = json['longitude'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
