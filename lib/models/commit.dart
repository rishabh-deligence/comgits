import 'package:comgits/models/commitDetails.dart';

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