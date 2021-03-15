import 'dart:convert';

import 'package:hmpaisrn/data/models/mission.dart';
import 'package:hmpaisrn/data/models/pad.dart';
import 'package:hmpaisrn/data/models/rocket/rocket.dart';
import 'package:hmpaisrn/data/models/status.dart';
import 'package:hmpaisrn/data/models/vidurls.dart';
import 'package:http/http.dart' as http;

import 'agency.dart';

class Launch {
  final String id;
  final String name;
  final String infographic;
  final String image;
  final String slug;
  final DateTime windowStart;
  final DateTime windowEnd;
  final DateTime net;
  final int probability;
  final Status status;
  final Rocket rocket;
  final Agency launchServiceProvider;
  final Pad pad;
  final Mission mission;
  final List<VidURL> vidURLs;

  const Launch(
      {this.id,
      this.name,
      this.status,
      this.windowStart,
      this.windowEnd,
      this.net,
      this.probability,
      this.rocket,
      this.pad,
      this.mission,
      this.vidURLs,
      this.launchServiceProvider,
      this.image,
      this.infographic,
      this.slug});

  static Launch fromResponse(http.Response response) {
    var decodedJson =
        json.decode(utf8.decode(response.bodyBytes)).cast<String, dynamic>();
    return Launch.fromJson(decodedJson);
  }

  factory Launch.fromJson(Map<String, dynamic> json) {
    var mission;
    if (json['mission'] != null) {
      mission = new Mission.fromJson(json['mission']);
    }

    var vidURLs;
    if (json['vidURLs'] != null) {
      vidURLs = new List<VidURL>.from(
          json['vidURLs'].map((vidURL) => new VidURL.fromJson(vidURL)));
    }

    return new Launch(
      id: json['id'],
      name: json['name'],
      infographic: json['infographic'],
      image: json['image'],
      slug: json['slug'],
      status: new Status.fromJson(json['status']),
      windowStart: DateTime.parse(json['window_start']),
      windowEnd: DateTime.parse(json['window_end']),
      net: DateTime.parse(json['net']),
      probability: json['probability'],
      launchServiceProvider:
          new Agency.fromJson(json['launch_service_provider']),
      rocket: new Rocket.fromJson(json['rocket']),
      pad: new Pad.fromJson(json['pad']),
      mission: mission,
      vidURLs: vidURLs,
    );
  }
}
