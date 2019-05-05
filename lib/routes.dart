import 'package:flutter/material.dart';
import 'package:hmpaisrn/services/peopleinspace.dart';

import 'screens/home/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/Home': (BuildContext context) => new Home(),
    '/List': (BuildContext context) => new Home(),
    '/Detail': (BuildContext context) => new Home()
  };

  Routes () {
    runApp(Home());
  }
}