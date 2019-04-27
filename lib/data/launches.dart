import 'package:hmpaisrn/data/rockets.dart';

class Launches {
  String name;
  int id;
  String net;
  int tbddate;
  int tbdtime;
  int status;
  String windowstart;
  String windowend;
  List<String> vidURLs;
  String vidURL;
  int probability;
  String changed;
  Map<String, dynamic> lsp;
  Rocket rocket;

  Launches(
      {this.id,
      this.name,
      this.net,
      this.tbddate,
      this.tbdtime,
      this.status,
      this.windowstart,
      this.windowend,
      this.vidURLs,
      this.vidURL,
      this.probability,
      this.changed,
      this.lsp,
      this.rocket});

  Launches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    net = json['net'];
    tbddate = json['tbddate'];
    tbdtime = json['tbdtime'];
    status = json['status'];
    windowstart = json['windowstart'];
    windowend = json['windowend'];
    vidURL = json['vidURL'];
    vidURLs = List.castFrom(json['vidURLs']);
    probability = json['probability'];
    changed = json['changed'];
    lsp = json['lsp'];
    rocket = Rocket.fromJson(json['rocket']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['net'] = this.net;
    data['tbddate'] = this.tbddate;
    data['tbdtime'] = this.tbdtime;
    data['status'] = this.status;
    data['windowstart'] = this.windowstart;
    data['windowend'] = this.windowend;
    data['vidURLs'] = this.vidURLs;
    data['vidURL'] = this.vidURL;
    data['probability'] = this.probability;
    data['changed'] = this.changed;
    data['lsp'] = this.lsp;
    data['rocket'] = this.rocket;
    return data;
  }
}
