import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/people.dart';
import 'package:hmpaisrn/screens/detail/planet_summary.dart';
import 'package:hmpaisrn/util/text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPage extends StatelessWidget {
  final People people;

  const DetailPage({Key key, this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(people.name),
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
      child: new Image(image: new CachedNetworkImageProvider(people.biophoto), height: 300.0, fit: BoxFit.contain),
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
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new PlanetSummary(
            people,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle, style: Style.headerTextStyle),
                new Separator(),
                new Text(people.bio, style: Style.commonTextStyle),
                new Container(height: 8.0),
                Visibility(
                    visible: people.twitter.isNotEmpty,
                    child: new InkWell(
                        child: Text("Twitter",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => launch(people.twitter))),
                new Container(height: 6.0),
                Visibility(
                    visible: people.biolink.isNotEmpty,
                    child: new InkWell(
                        child: Text("Biolink",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => launch(people.biolink)))
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
