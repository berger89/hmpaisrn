import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/data/people.dart';

class AppDataState {
  final People peopleInSpace;
  final Launch nextLaunch;
  final Launch previousLaunch;
  final Launch searchLaunch;

  AppDataState({ this.peopleInSpace, this.nextLaunch, this.previousLaunch, this.searchLaunch  });

  AppDataState copyWith({ peopleInSpace, nextLaunch, previousLaunch, searchLaunch }) {
		return new AppDataState(
			peopleInSpace: peopleInSpace ?? this.peopleInSpace,
			nextLaunch: nextLaunch ?? this.nextLaunch,
			previousLaunch: previousLaunch ?? this.previousLaunch,
			searchLaunch: searchLaunch ?? this.searchLaunch,
		);
	}
}