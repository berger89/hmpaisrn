import 'package:hmpaisrn/data/agencies.dart';

class Location {
  int id;
  String name;
  String infoURL;
  String wikiURL;
  String countryCode;
  Agencies agencies;

  Location({this.id, this.name, this.wikiURL, this.infoURL, this.countryCode});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    wikiURL = json['wikiURL'];
    infoURL = json['infoURL'];
    countryCode = json['countryCode'];
    if (json['agencies'] != null)
      agencies = Agencies.fromJson(json['agencies']);
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
