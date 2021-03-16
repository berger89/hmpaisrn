import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hmpaisrn/data/models/launch.dart';
import 'package:hmpaisrn/screens/rocket/detail/planet_summary.dart';
import 'package:hmpaisrn/util/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketDetailPage extends StatelessWidget {
  final Launch launches;

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
            _getContent(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: new Image(
          image: launches.image != null
              ? new CachedNetworkImageProvider(launches.image)
              : AssetImage('assets/icon_hmpaisrn.png'),
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

  Container _getContent(BuildContext context) {
    final _overviewTitle = "Overview".toUpperCase();
    String twitterUrl = "";
    String youtubeUrl = "";
    String linkedinUrl = "";
    String instagramUrl = "";
    String facebookUrl = "";
    String homeUrl = "";

    final String assetTwitter = 'assets/twitter_icon.svg';
    final String assetWeb = 'assets/web_icon.svg';
    final String assetYoutube = 'assets/youtube_icon.svg';
    final String assetFacebook = 'assets/facebook_icon.svg';
    final String assetInstagram = 'assets/instagram_icon.svg';
    final String assetLinkedin = 'assets/linkedin_icon.svg';

    Set<Marker> markers = new Set<Marker>();
    double lat = 0.0;
    double long = 0.0;
    if (launches.pad.location != null) {
      lat = launches.pad.latitude;
      long = launches.pad.longitude;
      markers.add(Marker(
          markerId: MarkerId(launches.pad.id.toString()),
          position: new LatLng(lat, long)));
    }
    if (launches.rocket.configuration.infoUrl != null)
      homeUrl = launches.rocket.configuration.infoUrl;

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
                    launches.mission != null
                        ? launches.mission.description
                        : "Mission infos not available",
                    style: Style.commonTextStyle),
                new Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: new Text(launches.pad.location.name)),
                new Visibility(
                    child: new Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: new Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: new Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(lat, long),
                                              zoom: 10.0),
                                          markers: markers,
                                          gestureRecognizers: Set()
                                            ..add(Factory<PanGestureRecognizer>(
                                                () => PanGestureRecognizer()))
                                            ..add(Factory<
                                                    VerticalDragGestureRecognizer>(
                                                () =>
                                                    VerticalDragGestureRecognizer())),
                                          rotateGesturesEnabled: false,
                                          scrollGesturesEnabled: true,
                                          tiltGesturesEnabled: true,
                                        )))))),
                    visible: launches.pad != null ? true : false),
                new Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                            visible: twitterUrl.isNotEmpty,
                            child: new Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: new InkWell(
                                    child: getSvgIcon(assetTwitter),
                                    onTap: () => launch(twitterUrl)))),
                        new Container(height: 6.0),
                        Visibility(
                            visible: youtubeUrl.isNotEmpty,
                            child: new Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: new InkWell(
                                    child: getSvgIcon(assetYoutube),
                                    onTap: () => launch(youtubeUrl)))),
                        new Container(height: 6.0),
                        Visibility(
                            visible: facebookUrl.isNotEmpty,
                            child: new Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: new InkWell(
                                    child: getSvgIcon(assetFacebook),
                                    onTap: () => launch(facebookUrl)))),
                        new Container(height: 6.0),
                        Visibility(
                            visible: linkedinUrl.isNotEmpty,
                            child: new Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: new InkWell(
                                    child: getSvgIcon(assetLinkedin),
                                    onTap: () => launch(linkedinUrl)))),
                        new Container(height: 6.0),
                        Visibility(
                            visible: instagramUrl.isNotEmpty,
                            child: new Padding(
                                padding: EdgeInsets.only(right: 30.0),
                                child: new InkWell(
                                    child: getSvgIcon(assetInstagram),
                                    onTap: () => launch(instagramUrl)))),
                        new Container(height: 6.0),
                        Visibility(
                            visible: homeUrl.isNotEmpty,
                            child: new InkWell(
                                child: getSvgIcon(assetWeb),
                                onTap: () => launch(homeUrl))),
                        new Container(height: 6.0)
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  getSvgIcon(String path) {
    return new SvgPicture.asset(
      path,
      height: 30,
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
