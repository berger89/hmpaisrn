import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hmpaisrn/actions/fetch_actions.dart';
import 'package:hmpaisrn/data/models/launch.dart';
import 'package:hmpaisrn/data/models/launches.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';
import 'package:redux/redux.dart';

class PreviousListScreen extends StatefulWidget {
  final Launch launch;

  @override
  _PreviousListScreenState createState() => _PreviousListScreenState();

  const PreviousListScreen({Key key, this.launch}) : super(key: key);
}

class _PreviousListScreenState extends State<PreviousListScreen> {
  DateTime startdate;
  DateTime enddate;

  static const INCREMENT_DAYS = Duration(days: 14);

  @override
  void initState() {
    startdate = DateTime.now().subtract(Duration(days: 90));
    enddate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _PreviousModel>(
      converter: _PreviousModel.fromStore,
      builder: (BuildContext context, _PreviousModel model) {
        if (model.previousLaunch == null ||
            model.previousLaunch.launches == null) {
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

        return LaunchList(
            launches: model.previousLaunch.launches,
            onScrollEnd: () async {
              startdate = startdate.subtract(INCREMENT_DAYS);

              model.fetchPrevious(startdate, enddate);
            });
      },
    );
  }
}

class _PreviousModel {
  final Launches previousLaunch;
  final bool loading;
  final void Function(DateTime startdate, DateTime enddate) fetchPrevious;

  _PreviousModel({this.previousLaunch, this.loading, this.fetchPrevious});

  static _PreviousModel fromStore(Store<AppState> store) {
    return _PreviousModel(
        previousLaunch: store.state.appData.previousLaunch,
        loading: store.state.appData.loading,
        fetchPrevious: (DateTime startdate, DateTime enddate) {
          store.dispatch(fetchPreviousLaunchesAction(startdate, enddate));
        });
  }
}
