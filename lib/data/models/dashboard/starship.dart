import 'package:hmpaisrn/data/models/rocket/launcher.dart';

import 'launch_event_list.dart';
import 'live_stream.dart';
import 'notice.dart';
import 'road_closure.dart';

class Starship {
  final LaunchEventList upcoming;
  final LaunchEventList previous;
  final List<LiveStream> liveStream;
  final List<RoadClosure> roadClosures;
  final List<Notice> notices;
  final List<Launcher> launchers;

  Starship(
      {this.upcoming,
      this.previous,
      this.liveStream,
      this.roadClosures,
      this.notices,
      this.launchers});

  factory Starship.fromJson(Map<String, dynamic> json) {
    return new Starship(
      upcoming: new LaunchEventList.fromJson(json['upcoming']),
      previous: new LaunchEventList.fromJson(json['previous']),
      liveStream: new List<LiveStream>.from(json['live_streams']
          .map((stream) => new LiveStream.fromJson(stream))),
      roadClosures: new List<RoadClosure>.from(json['road_closures']
          .map((closure) => new RoadClosure.fromJson(closure))),
      notices: new List<Notice>.from(
          json['notices'].map((notice) => new Notice.fromJson(notice))),
      launchers: new List<Launcher>.from(
          json['vehicles'].map((notice) => new Launcher.fromJson(notice))),
    );
  }
}
