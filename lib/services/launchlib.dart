import 'dart:convert';
import 'dart:async';

import 'package:async/async.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:http/http.dart' as http;

final AsyncMemoizer _memoizer = AsyncMemoizer();

fetchNextLaunches({next = 20, offset = 0}) {
  return _memoizer.runOnce(() async {
    final queryParameters = {
      'next': next.toString(),
      'offset': offset.toString(),
      'mode': 'verbose'
    };

    final uri =
        Uri.https('launchlibrary.net', '/1.4/launch', queryParameters);

    return handleGetCall(uri);
  });
}

fetchPreviousLaunches({startdate, enddate, limit = 500}) {
  return _memoizer.runOnce(() async {
    if (startdate == null) {
      startdate = DateTime.now().subtract(Duration(days: 14)).toUtc();
    }

    if (enddate == null) {
      enddate = DateTime.now().toUtc();
    }

    final queryParameters = {
      'limit': 500,
      'startdate': startdate,
      'enddate': enddate
    };

    final uri =
        Uri.https('launchlibrary.net', '/1.4/launch', queryParameters);

    return handleGetCall(uri);
  }); 
}

Future<Launch> handleGetCall(Uri uri) async {
  final response = await http.get(uri);

  if (response.statusCode <= 299) {
    var launches = Launch.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // If the call to the server was successful, parse the JSON
    return launches;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}