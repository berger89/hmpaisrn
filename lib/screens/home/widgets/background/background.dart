import 'package:flutter/material.dart';
import 'package:hmpaisrn/widgets/app_background/app_background.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBackground(
        assetImage: new AssetImage("assets/space_bg.jpg"),
        boxFit: BoxFit.cover);
  }
}
