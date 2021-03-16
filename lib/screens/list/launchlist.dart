import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/models/launch.dart';
import 'package:hmpaisrn/screens/rocket/detail/detail.dart';
import 'package:hmpaisrn/util/DateUtil.dart';

class LaunchList extends StatefulWidget {
  final List<Launch> launches;
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
      if (widget.onScrollEnd != null) {
        widget.onScrollEnd();
      }
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
        children: _buildLaunchList(ctxt));
  }

  List<_LaunchesItem> _buildLaunchList(BuildContext ctxt) {
    return widget.launches
        .map((launch) => _LaunchesItem(launch, ctxt))
        .toList();
  }
}

class _LaunchesItem extends ListTile {
  _LaunchesItem(Launch launch, buildContext)
      : super(
          onTap: () => onTapped(launch, buildContext),
          title: Text(launch.name),
          subtitle: Text(DateUtil().formatUTCtoLocalTimeZone(DateUtil()
              .parseUTCtoLocalTimeZone(launch.windowStart.toUtc().toString()))),
          leading: new Container(
            width: 50.0,
            height: 50.0,
            child: ClipOval(
              child: launch.image != null
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: launch.image,
                      width: 50.0,
                      height: 50.0,
                    )
                  : Image.asset('assets/icon_hmpaisrn.png'),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
}

void onTapped(Launch launch, BuildContext context) {
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new RocketDetailPage(launches: launch)));
}
