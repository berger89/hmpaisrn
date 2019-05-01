import 'package:hmpaisrn/data/launches.dart';

class Launch {
  int offset;
  int total;
  int count;
  List<Launches> launches;

  Launch({this.count = 0, this.launches = const []});

  Launch.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['launches'] != null) {
      launches = new List<Launches>();
      json['launches'].forEach((v) {
        launches.add(new Launches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.launches != null) {
      data['launches'] = this.launches.map((v) => v.toJson()).toList();
    }
    return data;
  }
}