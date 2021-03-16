import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hmpaisrn/data/people/autogenerated.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/rocket_icons.dart';
import 'package:hmpaisrn/screens/home/widgets/text_number/index.dart';
import 'package:hmpaisrn/screens/info/index.dart';
import 'package:hmpaisrn/screens/rocket/previous/previous.dart';
import 'package:hmpaisrn/screens/rocket/search/search.dart';
import 'package:hmpaisrn/screens/rocket/upcoming/upcoming.dart';
import 'package:redux/redux.dart';

import 'widgets/background/index.dart';

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex;

  _HomeState() : super();

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      'People in Space',
      'Upcoming Rocket Launches',
      'Previous Rocket Launches',
      'Search Rocket Launches',
      'Info',
    ];

    final List<Widget> _children = [
      Stack(
        children: <Widget>[
          new Background(),
          new StoreConnector<AppState, Autogenerated>(
            converter: (Store<AppState> store) {
              return store.state.appData.peopleInSpace;
            },
            builder: (BuildContext context, Autogenerated people) {
              if (people != null &&
                  people.number != null &&
                  people.people != null) {
                return TextNumber(
                    autogeneratedNumber: people.number,
                    people: people.people,
                    fontSize: 188.0,
                    fontColor: Colors.white.withOpacity(0.8),
                    offline: false);
              }

              return TextNumber(
                  autogeneratedNumber: null,
                  people: null,
                  fontSize: 26.0,
                  fontColor: Colors.white.withOpacity(0.8),
                  offline: true);
            },
          )
        ],
      ),
      UpcomingListScreen(),
      PreviousListScreen(),
      SearchListScreen(),
      InfoScreen()
    ];

    return new MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: new AppBar(
            title: new Text(titles[_selectedIndex]),
          ),
          body: _children[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  title: Text(titles[0].split(" ")[0])),
              BottomNavigationBarItem(
                  icon: Icon(Rocket.rocket),
                  title: Text(titles[1].split(" ")[0])),
              BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  title: Text(titles[2].split(" ")[0])),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text(titles[3].split(" ")[0])),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  title: Text(titles[4].split(" ")[0])),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));

    // TODO offline handling...
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
