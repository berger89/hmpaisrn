import 'package:hmpaisrn/data/launch.dart';

class AppDataState {
  final Launch nextLaunch;
  final Launch previousLaunch;
  //TODO: more

  AppDataState({ this.nextLaunch, this.previousLaunch });

  AppDataState copyWith({ nextLaunch, previousLaunch }) {
		return new AppDataState(
			nextLaunch: nextLaunch ?? this.nextLaunch,
			previousLaunch: previousLaunch ?? this.previousLaunch,
		);
	}
}