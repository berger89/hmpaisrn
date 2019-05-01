import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:hmpaisrn/models/app_data_state.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/actions/fetch_actions.dart';

class UpcomingListScreen extends StatelessWidget {
  final Launch launch;

  const UpcomingListScreen({Key key, this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppDataState>(
      converter: (Store<AppState> store) {
        return 
          store.state.appData
        ;
      },
      builder: (BuildContext context, AppDataState appData) {
        return Scaffold(
        body: LaunchList(launches: appData.nextLaunch.launches));
      },
    );
  }
}
