import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Commit>> fetchCommit() async {
  final response = await http.get(
      'https://api.github.com/repos/facebook/react-native/commits?page=1&per_page=10');

  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Commit.fromJson(m)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load commit');
  }
}

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
  Future<List<Commit>> commit;

  @override
  void initState() {
    super.initState();
    commit = fetchCommit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Commit>>(
            future: commit,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Commit> commits = snapshot.data;
                return new ListView(
                  children: commits.map((commit) => Text(commit.sha)).toList(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
