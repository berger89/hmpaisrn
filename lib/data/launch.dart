import 'package:hmpaisrn/data/launches.dart';

class Launch {
  int count;
  List<Launches> results;

  String next;
  String previous;

  bool loading;

  Launch(
      {this.count = 0,
      this.results = const [],
      this.next,
      this.previous,
      this.loading = false});

  Launch.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }

    count = json['count'];
    next = json['next'];
    previous = json['previous'];

    if (json['results'] != null) {
      results = new List<Launches>();
      json['results'].forEach((v) {
        results.add(new Launches.fromJson(v));
      });
    }
    loading = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;

    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
