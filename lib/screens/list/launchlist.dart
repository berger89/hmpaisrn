import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launches.dart';
import 'package:hmpaisrn/screens/rocket/detail/detail.dart';

class LaunchList extends StatefulWidget {
  final List<Launches> launches;
  final onScrollEnd;

  @override
  _LaunchListState createState() => _LaunchListState();

  const LaunchList({Key key, this.launches, this.onScrollEnd})
      : super(key: key);
}

class _LaunchListState extends State<LaunchList> {
  ScrollController _controller;

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // reached the bottom
      widget.onScrollEnd();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // reached the top
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctxt) {
    return ListView(
        controller: _controller,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(ctxt));
  }

  List<_LaunchesItem> _buildContactList(BuildContext ctxt) {
    return widget.launches
        .map((launch) => _LaunchesItem(launch, ctxt))
        .toList();
  }
}

class _LaunchesItem extends ListTile {
  _LaunchesItem(Launches launches, buildContext)
      : super(
          onTap: () => onTapped(launches, buildContext),
          title: Text(launches.name),
          subtitle: Text(launches.windowstart),
          leading: new Container(
            width: 50.0,
            height: 50.0,
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: launches.rocket.thumbImageURL,
                width: 50.0,
                height: 50.0,
              ),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
}

void onTapped(Launches launches, BuildContext context) {
  // TODO ROCKET DETAIL PAGE
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new RocketDetailPage(launches: launches)));
}
