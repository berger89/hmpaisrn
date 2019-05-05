class Agencies {
  String name;
  int id;
  String abbrev;
  List<String> infoURLs;
  String infoURL;
  String countryCode;
  int type;
  String wikiURL;
  String changed;

  Agencies(
      {this.id,
      this.name,
      this.wikiURL,
      this.changed,
      this.infoURLs,
      this.infoURL,
      this.abbrev,
      this.countryCode,
      this.type});

  Agencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    wikiURL = json['wikiURL'];
    changed = json['changed'];
    infoURLs = List.castFrom(json['infoURLs']);
    infoURL = json['infoURL'];
    abbrev = json['abbrev'];
    countryCode = json['countryCode'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['wikiURL'] = this.wikiURL;
    data['changed'] = this.changed;
    data['infoURLs'] = this.infoURLs;
    data['infoURL'] = this.infoURL;
    data['abbrev'] = this.abbrev;
    data['type'] = this.type;
    data['countryCode'] = this.countryCode;
    return data;
  }
}
