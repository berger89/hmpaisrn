import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launches.dart';
import 'package:hmpaisrn/screens/rocket/detail/planet_summary.dart';
import 'package:hmpaisrn/util/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketDetailPage extends StatelessWidget {
  final Launches launches;

  const RocketDetailPage({Key key, this.launches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(launches.name),
      ),
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF303030),
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: new Image(
          image: new CachedNetworkImageProvider(launches.rocket.thumbImageURL),
          height: 300.0,
          fit: BoxFit.contain),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00303030), new Color(0xFF303030)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    String twitterUrl = "";
    String youtubeUrl = "";
    String homeUrl = "";
    if (launches.rocket.agencies != null)
      for (var url in launches.rocket.agencies.infoURLs) {
        if (url.contains("twitter")) {
          twitterUrl = url;
        } else if (url.contains("youtube")) {
          youtubeUrl = url;
        } else {
          homeUrl = url;
        }
      }

    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new RocketSummary(
            launches,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle, style: Style.headerTextStyle),
                new Separator(),
                new Text(
                    launches.missions != null
                        ? launches.missions.description
                        : "Mission infos not available",
                    style: Style.commonTextStyle),
                new Container(height: 8.0),
                Visibility(
                    visible: twitterUrl.isNotEmpty,
                    child: new InkWell(
                        child: Text("Twitter",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => launch(twitterUrl))),
                new Container(height: 6.0),
                Visibility(
                    visible: youtubeUrl.isNotEmpty,
                    child: new InkWell(
                        child: Text("Youtube",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => launch(youtubeUrl))),
                new Container(height: 6.0),
                Visibility(
                    visible: homeUrl.isNotEmpty,
                    child: new InkWell(
                        child: Text("Web",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => launch(homeUrl)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 68.0,
        color: new Color(0xffffffff));
  }
}
