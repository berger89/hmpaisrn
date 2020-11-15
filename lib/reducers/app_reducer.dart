import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/reducers/data_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    appData: appDataReducer(state.appData, action),
  );
}
