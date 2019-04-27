import 'dart:convert';
import 'dart:async';

import 'package:hmpaisrn/data/launch.dart';
import 'package:http/http.dart' as http;

Future<Launch> fetchLaunch() async {
  final response = await http
      .get('https://launchlibrary.net/1.4/launch',headers:{"charset":"utf-8","Accept-Charset":"utf-8"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Launch.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}