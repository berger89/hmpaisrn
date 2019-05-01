import 'package:redux/redux.dart';
import 'package:hmpaisrn/services/launchlib.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/data/launch.dart';

class FetchSetNextLaunchesAction {
  final Launch nextLaunch;

  FetchSetNextLaunchesAction({ this.nextLaunch });
}

void fetchNextLaunchesAction(Store<AppState> store) async {
  final fetchedLaunch = await fetchNextLaunches(next: 5);

  store.dispatch(new FetchSetNextLaunchesAction(nextLaunch: fetchedLaunch));
}
