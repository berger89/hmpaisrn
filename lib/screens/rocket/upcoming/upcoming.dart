import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';
import 'package:redux/redux.dart';

class UpcomingListScreen extends StatelessWidget {
  final Launch launch;

  const UpcomingListScreen({Key key, this.launch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Launch>(
      converter: (Store<AppState> store) {
        return store.state.appData.upcomingLaunch;
      },
      builder: (BuildContext context, Launch upcomingLaunch) {
        if (upcomingLaunch == null || upcomingLaunch.launches == null || upcomingLaunch.loading) {
          return Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox.expand(),
                  ),
                  CircularProgressIndicator(value: null),
                  Expanded(
                    child: SizedBox.expand(),
                  ),
                ]),
          );
        }

        return Scaffold(body: LaunchList(launches: upcomingLaunch.launches));
      },
    );
  }
}
