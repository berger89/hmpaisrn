class People {
  String name;
  String title;
  String country;
  String launchdate;
  String bio;
  String biophoto;
  String countryflag;
  String location;
  String twitter;
  String biolink;

  People(
      {this.name,
      this.title,
      this.country,
      this.launchdate,
      this.bio,
      this.biophoto,
      this.countryflag,
      this.location,
      this.twitter,
      this.biolink});

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    country = json['country'];
    launchdate = json['launchdate'];
    bio = json['bio'];
    biophoto = json['biophoto'];
    countryflag = json['countryflag'];
    location = json['location'];
    twitter = json['twitter'];
    biolink = json['biolink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['country'] = this.country;
    data['launchdate'] = this.launchdate;
    data['bio'] = this.bio;
    data['biophoto'] = this.biophoto;
    data['countryflag'] = this.countryflag;
    data['location'] = this.location;
    data['twitter'] = this.twitter;
    data['biolink'] = this.biolink;
    return data;
  }
}
