import 'package:flutter/material.dart';
import 'package:hmpaisrn/data/launch.dart';
import 'package:hmpaisrn/screens/list/launchlist.dart';
import 'package:hmpaisrn/services/launchlib.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:hmpaisrn/models/app_state.dart';
import 'package:hmpaisrn/actions/fetch_actions.dart';

class SearchListScreen extends StatefulWidget {
  final Launch launch;

  @override
  _SearchListScreenState createState() => _SearchListScreenState();

  const SearchListScreen({Key key, this.launch}) : super(key: key);
}

class _SearchListScreenState extends State<SearchListScreen> {
  String searchText;
  int limit;

  static const INCREMENT_DAYS = Duration(days: 14);

  @override
  void initState() {
    limit = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, _SearchModel>(
            converter: _SearchModel.fromStore,
            builder: (BuildContext context, _SearchModel model) {
              // if (model.searchLaunch == null || model.searchLaunch.launches == null) {
              //   // nothing searched
              // } else if (model.searchLaunch.launches.isEmpty) {
              //   // nothing found
              // }

              return Container(
                  margin: const EdgeInsets.all(10),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          child: TextField(
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffffffff),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.greenAccent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.greenAccent),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Search for Rockets',
                        ),
                        autofocus: false,
                        enabled: true,
                        onSubmitted: (text) async {
                          setState(() {
                            searchText = text;
                          });

                          model.fetchSearch(limit, text);
                        },
                      )),
                      Expanded(
                          child: SizedBox.expand(
                        child: LaunchList(
                            launches: model.searchLaunch.launches,
                            onScrollEnd: () async {
                              setState(() {
                                limit = limit + 20;
                              });

                              model.fetchSearch(limit, searchText);
                            }),
                      ))
                    ],
                  ));
            }));
  }
}

class _SearchModel {
  final Launch searchLaunch;
  final bool loading;
  final void Function(int limit, String searchText) fetchSearch;

  _SearchModel({this.searchLaunch, this.loading, this.fetchSearch});

  static _SearchModel fromStore(Store<AppState> store) {
    return _SearchModel(
        searchLaunch: store.state.appData.searchLaunch,
        loading: store.state.appData.loading,
        fetchSearch: (int limit, String searchText) {
          store.dispatch(fetchSearchLaunchesAction(limit, searchText));
        });
  }
}
