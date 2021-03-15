import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:hmpaisrn/data/models/launches.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final AsyncMemoizer _memoizer = AsyncMemoizer();

final formatter = new DateFormat('yyyy-MM-dd');

var launchPath = '/2.1.0/launch';
var upLaunchPath = '/upcoming';
var prevLaunchPath = '/previous';

var uri = Uri.https('ll.thespacedevs.com', launchPath);
var upLaunchUri = Uri.https('ll.thespacedevs.com', launchPath + upLaunchPath);
var prevLaunchUri =
    Uri.https('ll.thespacedevs.com', launchPath + prevLaunchPath);

fetchUpcomingLaunches({next = 20, offset = 0}) {
  return _memoizer.runOnce(() async {
    final queryParameters = {
      'limit': next.toString(),
      'offset': offset.toString(),
      'ordering': 'net',
      'mode': 'detailed'
    };

    upLaunchUri = upLaunchUri.replace(queryParameters: queryParameters);

    return handleGetCall(upLaunchUri);
  });
}

fetchPreviousLaunches({startdate, enddate, limit = 500}) {
  if (startdate == null) {
    startdate = DateTime.now().subtract(Duration(days: 90));
  }

  if (enddate == null) {
    enddate = DateTime.now();
  }

  final queryParameters = {
    'limit': limit.toString(),
    'ordering': '-net',
    'mode': 'detailed'
  };

  prevLaunchUri = prevLaunchUri.replace(queryParameters: queryParameters);

  return handleGetCall(prevLaunchUri);
}

fetchSearchLaunches({name = '', limit = 200}) {
  final queryParameters = {
    'limit': limit.toString(),
    'search': name.toString(),
    'ordering': '-net',
    'mode': 'detailed'
  };

  uri=uri.replace(queryParameters: queryParameters);

  return handleGetCall(uri);
}

Future<Launches> handleGetCall(Uri uri) async {
  final response = await http.get(uri);

  if (response.statusCode <= 299) {
    var launches =
        Launches.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // If the call to the server was successful, parse the JSON
    return launches;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post: ${response.statusCode}');
  }
}
