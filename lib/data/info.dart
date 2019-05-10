import 'package:flutter/material.dart';

class Info {
  final String title;
  final String subtitle;
  final String url;
  final IconData icon;

  const Info({this.title, this.subtitle, this.url, this.icon});
}

const infos = const <Info>[
  const Info(
      title: 'About HMPAISRN!',
      subtitle: 'Version 1.1',
      url: '',
      icon: Icons.info),
  const Info(
      title: 'Launch Library API',
      subtitle: 'Using the Launch Library API',
      url: 'http://www.launchlibrary.net',
      icon: Icons.cloud_circle),
  const Info(
      title: 'Number of People in Space API',
      subtitle: 'Using the Open Notify API',
      url: 'http://www.open-notify.org',
      icon: Icons.cloud_circle),
  const Info(
      title: 'Open Source',
      subtitle: 'Source Code is available on GitHub',
      url: 'http://www.github.com/berger89/hmpaisrn',
      icon: Icons.public),
  const Info(
      title: 'Built with Flutter',
      subtitle: 'Visit flutter.dev',
      url: 'http://www.flutter.dev',
      icon: Icons.favorite_border),
  const Info(
      title: 'Created by Alexander Berger',
      subtitle: 'Visit berger-apps.de',
      url: 'http://www.berger-apps.de',
      icon: Icons.tag_faces),
  const Info(
      title: 'Created by Marius Reimer',
      subtitle: 'Visit mariusreimer.com',
      url: 'http://www.mariusreimer.com',
      icon: Icons.tag_faces)
];
