class People {
  String name;
  String title;
  String country;
  String launchdate;
  String bio;

  People({this.name, this.title, this.country, this.launchdate, this.bio});

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    country = json['country'];
    launchdate = json['launchdate'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['country'] = this.country;
    data['launchdate'] = this.launchdate;
    data['bio'] = this.bio;
    return data;
  }
}