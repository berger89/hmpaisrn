import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/data/launches.dart';

class UpcomingListScreen extends StatelessWidget {
  final Launch launch;

  const UpcomingListScreen({Key key, this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 1;
    return Scaffold(
        body: LaunchList(launches: launch.launches));
  }
}

class LaunchList extends StatelessWidget {
  final List<Launches> launches;

  const LaunchList({Key key, this.launches}) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(ctxt));
  }

  List<_LaunchesItem> _buildContactList(BuildContext ctxt) {
    return launches.map((launch) => _LaunchesItem(launch, ctxt)).toList();
  }
}

class _LaunchesItem extends ListTile {
  _LaunchesItem(Launches launches, buildContext)
      : super(
      onTap: () => onTapped(launches, buildContext),
      title: Text(launches.name),
      subtitle: Text(launches.windowstart),
      leading: new Container(
        width: 45.0,
        height: 45.0,
        child: ClipOval(
          child: CachedNetworkImage(
            //TODO image url
            imageUrl: "https://cdn.pixabay.com/photo/2017/01/05/11/08/rocket-1954808_1280.png",
            width: 45.0,
            height: 45.0,
          ),
        ),
      ));
}

void onTapped(Launches launches, BuildContext context) {
  // TODO ROCKET DETAIL PAGE
  /*Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new DetailPage(people: null)));
          */
}
