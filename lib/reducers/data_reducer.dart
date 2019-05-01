import 'package:hmpaisrn/actions/fetch_actions.dart';
import 'package:hmpaisrn/models/app_data_state.dart';

AppDataState appDataReducer(AppDataState appDataState, action) {
  if (action is FetchSetNextLaunchesAction) {
    appDataState = appDataState.copyWith(nextLaunch: action.nextLaunch);
	}
  return appDataState;
}
