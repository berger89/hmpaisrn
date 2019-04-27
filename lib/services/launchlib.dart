import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:http/http.dart' as http;

final AsyncMemoizer _memoizer = AsyncMemoizer();

final formatter = new DateFormat('yyyy-MM-dd');

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

fetchSearchLaunches({name = '', limit = 200}) {
  final queryParameters = {
    'limit': limit.toString(),
    'name': name.toString(),
    'mode': 'verbose',
    'sort': 'desc'
  };

  final uri =
      Uri.https('launchlibrary.net', '/1.4/launch', queryParameters);

  return handleGetCall(uri);
}

fetchPreviousLaunches({startdate, enddate, limit = 500}) {
  if (startdate == null) {
    startdate = DateTime.now().subtract(Duration(days: 90));
  }

  if (enddate == null) {
    enddate = DateTime.now();
  }

  final queryParameters = {
    'limit': '500',
    'startdate': formatter.format(startdate),
    'enddate': formatter.format(enddate),
    'mode': 'verbose',
    'sort': 'desc'
  };

  final uri =
      Uri.https('launchlibrary.net', '/1.4/launch', queryParameters);

  return handleGetCall(uri);
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