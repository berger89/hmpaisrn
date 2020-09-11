import 'package:hmpaisrn/data/autogenerated.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/models/app_data_state.dart';

class AppState {
  final AppDataState appData;

  AppState({appData}) : this.appData = _init(appData);

  AppState copyWith({appData}) {
    return new AppState(
      appData: appData ?? this.appData,
    );
  }

  static AppState fromJson(dynamic json) => AppState(
      appData: json == null
          ? new AppDataState()
          : AppDataState.fromJson(json["appData"]));

  dynamic toJson() => {'appData': appData};

  static AppDataState _init(dynamic appData) {
    if (appData != null) {
      return appData;
    }
    return new AppDataState(
        upcomingLaunch: Launch(),
        previousLaunch: Launch(),
        searchLaunch: Launch(),
        peopleInSpace: Autogenerated());
  }
}
