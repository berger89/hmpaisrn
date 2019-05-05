import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';
import 'package:hmpaisrn/services/launchlib.dart';

class SearchListScreen extends StatefulWidget {
  final Launch launch;

  @override
  _SearchListScreenState createState() => _SearchListScreenState();

  const SearchListScreen({Key key, this.launch}) : super(key: key);
}

class _SearchListScreenState extends State<SearchListScreen> {
  Launch launch;
  String searchText;
  int limit;

  static const INCREMENT_DAYS = Duration(days: 14);

  @override
  void initState() {
    launch = new Launch(count: 0, launches: new List(0));
    limit = 20;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SearchListScreen oldWidget) {
    launch = oldWidget.launch;
    super.didUpdateWidget(oldWidget);
  }

  fetchSearch() async {
    final fetchedLaunch =
        await fetchSearchLaunches(name: searchText, limit: limit);

    setState(() {
      launch = fetchedLaunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          margin: const EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  child: TextField(
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.greenAccent),
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.greenAccent),
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Search for Rockets',
                ),
                autofocus: false,
                enabled: true,
                onSubmitted: (text) async {
                  setState(() {
                    searchText = text;
                  });

                  fetchSearch();
                },
              )),
              Expanded(
                  child: SizedBox.expand(
                child: LaunchList(
                    launches: launch.launches,
                    onScrollEnd: () async {
                      setState(() {
                        limit = limit + 20;
                      });

                      fetchSearch();
                    }),
              ))
            ],
          )),
    );
  }
}
