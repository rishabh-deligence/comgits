import 'package:json_annotation/json_annotation.dart';


part 'committer.g.dart';

@JsonSerializable()
class Committer {
  final String name;
  final String email;
  final String date;

  Committer({this.name, this.email, this.date});


  factory Committer.fromJson(Map<String, dynamic> json) =>
      _$CommitterFromJson(json);

  Map<String, dynamic> toJson() => _$CommitterToJson(this);
}