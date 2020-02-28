import 'package:json_annotation/json_annotation.dart';

import 'package:comgits/models/committer.dart';

part 'commitDetails.g.dart';

@JsonSerializable(explicitToJson: true)
class CommitDetails {
  final String message;
  final Committer committer;

  CommitDetails({this.message, this.committer});

  factory CommitDetails.fromJson(Map<String, dynamic> json) =>
      _$CommitDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CommitDetailsToJson(this);
}
