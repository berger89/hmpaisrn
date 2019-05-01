import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/info.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InfoList());
  }
}

class InfoList extends StatelessWidget {
  const InfoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(ctxt));
  }

  List<_PeopleListItem> _buildContactList(BuildContext ctxt) {
    return infos.map((info) => _PeopleListItem(info, ctxt)).toList();
  }
}

class _PeopleListItem extends ListTile {
  _PeopleListItem(Info info, buildContext)
      : super(
          onTap: () => onTapped(info, buildContext),
          title: Text(info.title),
          subtitle: Text(info.subtitle),
          leading: new Container(
            width: 50.0,
            height: 50.0,
            child: ClipOval(
              child: Icon(info.icon),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
}

void onTapped(Info info, BuildContext context) async {
  if (info.url.isNotEmpty) {
    if (await canLaunch(info.url)) {
      await launch(info.url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
