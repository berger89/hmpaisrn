import 'package:redux/redux.dart';
import 'package:hmpaisrn/services/launchlib.dart';
import 'package:hmpaisrn/services/peopleinspace.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/data/autogenerated.dart';

class FetchSetNextLaunchesLoadingAction {
  final bool loading;

  FetchSetNextLaunchesLoadingAction({ this.loading });
}

class FetchSetNextLaunchesAction {
  final Launch nextLaunch;

  FetchSetNextLaunchesAction({ this.nextLaunch });
}

class FetchSetPeopleInSpaceLoadingAction {
  final bool loading;

  FetchSetPeopleInSpaceLoadingAction({ this.loading });
}

class FetchSetPeopleInSpaceAction {
  final Autogenerated autogenerated;

  FetchSetPeopleInSpaceAction({ this.autogenerated });
}

void fetchPeopleInSpaceAction(Store<AppState> store) async {
  store.dispatch(new FetchSetPeopleInSpaceLoadingAction(loading: true));

  final peopleInSpace = await fetchPeopleInSpace();

  store.dispatch(new FetchSetPeopleInSpaceLoadingAction(loading: false));

  store.dispatch(new FetchSetPeopleInSpaceAction(autogenerated: peopleInSpace));
}

void fetchNextLaunchesAction(Store<AppState> store) async {
  store.dispatch(new FetchSetNextLaunchesLoadingAction(loading: true));

  final fetchedLaunch = await fetchNextLaunches(next: 5);

  store.dispatch(new FetchSetNextLaunchesLoadingAction(loading: false));

  store.dispatch(new FetchSetNextLaunchesAction(nextLaunch: fetchedLaunch));
}