import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final AssetImage assetImage;
  final BoxFit boxFit;

  //passing props in react style
  AppBackground({this.assetImage, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: assetImage,
          fit: boxFit,
        ),
      ),
    );
  }
}
