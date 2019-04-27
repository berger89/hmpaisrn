import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';
import 'package:hmpaisrn/services/launchlib.dart';

class PreviousListScreen extends StatefulWidget {
  final Launch launch;

  @override
  _PreviousListScreenState createState() => _PreviousListScreenState();

  const PreviousListScreen({Key key, this.launch}) : super(key: key);  
}

class _PreviousListScreenState extends State<PreviousListScreen> {
  DateTime startdate;
  DateTime enddate;
  Launch launch;

  static const INCREMENT_DAYS = Duration(days: 14);

  @override
  void initState() {
    startdate = DateTime.now().subtract(Duration(days: 90));
    enddate = DateTime.now();
    launch = new Launch(count: 0,launches: new List(0));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(PreviousListScreen oldWidget) {
    launch = oldWidget.launch;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LaunchList(launches: launch.launches, onScrollEnd: () async {
          startdate = startdate.subtract(INCREMENT_DAYS);
          //TODO: [mr] loading indicator
          var fetchedLaunch = await fetchPreviousLaunches(startdate: startdate, enddate: enddate);

          setState(() {
            launch = fetchedLaunch;
          });

        }));
  }
}
