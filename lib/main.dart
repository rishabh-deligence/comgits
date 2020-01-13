import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Commit {
  final String sha;
  final Commitdetails commit;

  Commit({this.sha, this.commit});

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      sha: json['sha'],
      commit: new Commitdetails.fromJson(json['commit']),
    );
  }
}

class Commitdetails {
  final String message;
  final Committer committer;

  Commitdetails({this.message, this.committer});

  factory Commitdetails.fromJson(Map<String, dynamic> json) {
    return Commitdetails(
      message: json['message'],
      committer: new Committer.fromJson(json['committer']),
    );
  }
}

class Committer {
  final String name;
  final String email;
  final String date;

  Committer({this.name, this.email, this.date});

  factory Committer.fromJson(Map<String, dynamic> json) {
    return Committer(
      name: json['name'],
      email: json['email'],
      date: json['date'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageNumber = 1;
  var items = List();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchCommit();
  }

  Future<List> fetchCommit() async {
    final response = await http.get(
        'https://api.github.com/repos/facebook/react-native/commits?page=$pageNumber&per_page=10');
    if (response.statusCode == 200) {
      pageNumber++;
      List responseJson = json.decode(response.body);
      items.addAll(responseJson.map((m) => new Commit.fromJson(m)));
      setState(() {
        isLoading = false;
      });
      return items;
    } else {
      throw Exception('Failed to load commit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comgits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Comgits'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    fetchCommit();
                    setState(() {
                      isLoading = true;
                    });
                  }
                  return false;
                },
                child: ListView(
                  children: items
                      .map((commit) => Container(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 12.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                text: 'Unique ID : ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              TextSpan(text: '${commit.sha}  ')
                                            ]),
                                      ),
                                      SizedBox(height: 5),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18),
                                            children: [
                                              TextSpan(
                                                text: 'Committer : ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              TextSpan(
                                                  text:
                                                      '${commit.commit.committer.email} ')
                                            ]),
                                      ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Container(
              height: isLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
