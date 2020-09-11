import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hmpaisrn/data/launches.dart';
import 'package:hmpaisrn/screens/rocket/detail/detail.dart';
import 'package:hmpaisrn/util/DateUtil.dart';
import 'package:hmpaisrn/util/text_style.dart';
import 'package:intl/intl.dart';

class RocketSummary extends StatelessWidget {
  final Launches launches;
  final bool horizontal;

  RocketSummary(this.launches, {this.horizontal = true});

  RocketSummary.vertical(this.launches) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    String agenciesName = launches.rocket.agencies != null
        ? "from: " + launches.rocket.agencies.name
        : "";
    String streamUrl = launches.vidURLs != null && launches.vidURLs.isNotEmpty
        ? "\nStream: " + launches.vidURLs[0]
        : "";
    String googleMapsLink =
        launches.location.pads != null && launches.location.pads.isNotEmpty
            ? "\n\nSee on Google Maps: http://www.google.com/maps/place/" +
                launches.location.pads[0].latitude.toString() +
                "," +
                launches.location.pads[0].latitude.toString()
            : "";

    Widget _planetValue({String value, String image}) {
      return new Container(
          margin: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: new Text(value, overflow: TextOverflow.ellipsis));
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(launches.name,
              style: Style.titleTextStyle, overflow: TextOverflow.ellipsis),
          new Container(height: 1.0),
          new Container(
              margin: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: new Text(
                  launches.location != null
                      ? launches.location.countryCode
                      : "",
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle)),
          new Separator(),
          new Container(height: 4.0),
          getTimer(launches.windowstart),
          new Expanded(
              child: _planetValue(
                  value: launches.rocket.agencies != null
                      ? launches.rocket.agencies.name
                      : "",
                  image: "")),
          new GestureDetector(
            child: SvgPicture.asset(
              "assets/share_icon.svg",
              height: 30,
            ),
            onTap: () {
              Share.text(
                  "Launch",
                  launches.name +
                      " " +
                      agenciesName +
                      " launches at " +
                      launches.windowstart +
                      ". \n\nLocation: " +
                      launches.location.name +
                      ". " +
                      streamUrl +
                      googleMapsLink,
                  'text/plain');
            },
          )
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: horizontal ? 110.0 : 200.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 20.0)
          : new EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF303030).withOpacity(0.8),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new GestureDetector(
        onTap: horizontal
            ? () => Navigator.of(context).push(
                  new PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        new RocketDetailPage(launches: launches),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                            child) =>
                        new FadeTransition(opacity: animation, child: child),
                  ),
                )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
            ],
          ),
        ));
  }

  getTimer(String startDate) {
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          DateTime parsedDate=DateUtil().parseUTCtoLocalTimeZone(startDate);
          Duration remaining = DateUtil().getRemainingTimeToUTCDate(startDate);
          var dateString =
              "${remaining.inDays}d:${remaining.inHours % 24}h:${remaining.inMinutes % 60}m:${remaining.inSeconds % 60}s";
          print(dateString);
          return Container(
              alignment: Alignment.center,
              child: parsedDate.isAfter(DateTime.now())
                  ? new Text(dateString)
                  : new Text(startDate));
        });
  }
}
