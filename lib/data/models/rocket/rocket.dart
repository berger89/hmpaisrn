import 'package:hmpaisrn/data/models/rocket/first_stage.dart';
import 'package:hmpaisrn/data/models/rocket/launcher_configuration.dart';
import 'package:hmpaisrn/data/models/rocket/spacecraft/spacecraft_stage.dart';

class Rocket {
  final int id;
  final LauncherConfiguration configuration;
  final Iterable<FirstStage> firstStages;
  final SpacecraftStage spacecraftStage;

  Rocket({this.id, this.configuration, this.firstStages, this.spacecraftStage});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    var listFirstStages;
    if (json['launcher_stage'] != null) {
      var firstStagesJson = json['launcher_stage'];

      listFirstStages =
          (firstStagesJson as List).map((i) => new FirstStage.fromJson(i));
      for (final item in listFirstStages) {
        print(item.launcher.serialNumber);
      }
    }

    var spacecraftStage;
    if (json['spacecraft_stage'] != null) {
      spacecraftStage = new SpacecraftStage.fromJson(json['spacecraft_stage']);
    }

    return Rocket(
        id: json['id'],
        configuration:
            new LauncherConfiguration.fromJson(json['configuration']),
        firstStages: listFirstStages,
        spacecraftStage: spacecraftStage);
  }
}
