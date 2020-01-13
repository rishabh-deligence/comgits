
import 'package:comgits/models/committer.dart';

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