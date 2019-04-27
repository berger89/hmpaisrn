import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';

class UpcomingListScreen extends StatelessWidget {
  final Launch launch;

  const UpcomingListScreen({Key key, this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LaunchList(launches: launch.launches));
  }
}
