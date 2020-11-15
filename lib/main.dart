import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hmpaisrn/models/app_state.dart'; // new
import 'package:hmpaisrn/reducers/app_reducer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart'; // new
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'actions/fetch_actions.dart';
import 'models/app_state.dart';
import 'screens/home/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var appDir;

  try {
    appDir = await getApplicationDocumentsDirectory();
  } catch (e) {
    print(e);
  }

  final persistor = Persistor<AppState>(
    debug: false,
    throttleDuration: Duration(seconds: 2),
    storage: FlutterStorage(), // Or use other engines
    serializer:
        JsonSerializer<AppState>(AppState.fromJson), // Or use other serializers
  );

  var initialState = new AppState();

  try {
    // Load initial state
    initialState = await persistor.load();
  } catch (e) {
    print(e);
  }

  // Store holds your apps State tree
  // middleware to handle side-effects are configured here
  final store = new Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: [thunkMiddleware, persistor.createMiddleware()],
  );

  store.dispatch(fetchPeopleInSpaceAction);
  store.dispatch(fetchUpcomingLaunchesAction);
  store.dispatch(fetchPreviousLaunchesAction(null, null));

  runApp(new MainApp(
    store: store,
    title: 'People in Space',
  ));
}

class MainApp extends StatelessWidget {
  final Store store;
  final String title;

  MainApp({this.store, this.title});

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store, child: new Home(title: title));
  }
}
