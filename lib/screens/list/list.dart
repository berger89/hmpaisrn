import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/people.dart';
import 'package:hmpaisrn/screens/detail/detail.dart';
import 'package:path/path.dart';

class ListScreen extends StatelessWidget {
  final List<People> people;

  const ListScreen({Key key, this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("People In Space"),
        ),
        body: PeopleList(people: people));
  }
}

class PeopleList extends StatelessWidget {
  final List<People> people;

  const PeopleList({Key key, this.people}) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(ctxt));
  }

  List<_PeopleListItem> _buildContactList(BuildContext ctxt) {
    return people.map((people) => _PeopleListItem(people, ctxt)).toList();
  }
}

class _PeopleListItem extends ListTile {
  _PeopleListItem(People people, buildContext)
      : super(
    onTap: () => onTapped(people, buildContext),
    title: Text(people.name),
    subtitle: Text(people.title),
    leading: new Container(
        width: 45.0,
        height: 45.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fitWidth,
                image: new NetworkImage(people.biophoto)))),
  );
}

void onTapped(People people, BuildContext context) {
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new DetailPage(people: people)));
}
