import 'package:hmpaisrn/data/models/launch.dart';

class Launches {
  final List<Launch> launches;
  final int nextOffset;
  final int count;

  Launches({this.launches, this.nextOffset, this.count});

  factory Launches.fromJson(Map<String, dynamic> json) {
    int offset;
    if (json['next'] != null && json['next'].toString().isNotEmpty) {
      Uri offsetUri = Uri.parse(json['next']);
      offset = int.parse(offsetUri.queryParameters['offset']);
    }

    return new Launches(
        launches: new List<Launch>.from(
            json['results'].map((launch) => new Launch.fromJson(launch))),
        nextOffset: offset,
        count: json['count']);
  }
}
