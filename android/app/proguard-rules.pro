#https://stackoverflow.com/questions/41362386/execution-failed-for-task-apptransformclassesandresourceswithproguardforrelea
-ignorewarnings
-keep class * {
    public private *;
}
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }