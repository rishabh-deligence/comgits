import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:comgits/models/commit.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageNumber = 1;
  bool isDataAvailable = true;
  var items = List();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchCommit();
  }

  Future<List> fetchCommit() async {
    final response = await http.get(
        'https://api.github.com/repos/rishabh6072/BurgerTheBuilder/commits?page=$pageNumber&per_page=10');
    if (response.statusCode == 200) {
      pageNumber++;
      List responseJson = json.decode(response.body);

      if (responseJson.length < 10) isDataAvailable = false;

      items.addAll(responseJson.map((m) => new Commit.fromJson(m)));
      setState(() {
        isLoading = false;
      });
      return items;
    } else {
      throw Exception('Failed to load commit');
    }
  }

  Future<List> refreshCommit() async {
    items = List();
    pageNumber = 1;
    isDataAvailable = true;
    return fetchCommit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comgits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Comgits'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      isDataAvailable) {
                    fetchCommit();
                    setState(() {
                      isLoading = true;
                    });
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: refreshCommit,
                  child: ListView(
                    children: items
                        .map((commit) => Container(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                elevation: 12.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        textSection(
                                            'Unique ID', '${commit.sha}'),
                                        textSection('Commit',
                                            '${commit.commit.message}'),
                                        textSection('Committer Name',
                                            '${commit.commit.committer.name}'),
                                        textSection('Committer email',
                                            '${commit.commit.committer.email}'),
                                        textSection('Commit Date',
                                            '${commit.commit.committer.date}'),
                                      ],
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Container(
              height: isLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: const Center(
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  textSection(String title, String subtitle) {
    return subtitle == null || subtitle == '' || subtitle.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(subtitle,
                    style: TextStyle(color: Colors.black87, fontSize: 18)),
              ],
            ),
          );
  }
}
