class Missions {
  String name;
  int id;
  String description;
  String wikiURL;
  String countrycode;
  int type;
  String typeName;

  Missions(
      {this.id,
      this.name,
      this.wikiURL,
      this.countrycode,
      this.type,
      this.typeName,
      this.description});

  Missions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    wikiURL = json['wikiURL'];
    countrycode = json['countrycode'];
    type = json['type'];
    typeName = json['typeName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['wikiURL'] = this.wikiURL;
    data['type'] = this.type;
    data['countrycode'] = this.countrycode;
    return data;
  }
}
