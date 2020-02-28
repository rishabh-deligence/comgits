import 'package:comgits/models/commitDetails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit.g.dart';

@JsonSerializable(explicitToJson: true)
class Commit {

// Tell json_serializable that "registration_date_millis" should be
/// mapped to this property.
// @JsonKey(name: 'registration_date_millis')
// final int registrationDateMillis;

// Modifying @JsonSerializable(fieldRename: FieldRename.snake) 
// is equivalent to adding @JsonKey(name: '<snake_case>') to each field.


/// Tell json_serializable to use "defaultValue" if the JSON doesn't
/// contain this key or if the value is `null`.
// @JsonKey(defaultValue: false)
// final bool isAdult;

/// When `true` tell json_serializable that JSON must contain the key, 
/// If the key doesn't exist, an exception is thrown.
// @JsonKey(required: true)
// final String id;

/// When `true` tell json_serializable that generated code should 
/// ignore this field completely. 
// @JsonKey(ignore: true)
// final String verificationCode;

  final String sha;
  final CommitDetails commit;

  Commit({this.sha, this.commit});

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);

  Map<String, dynamic> toJson() => _$CommitToJson(this);

  // factory Commit.fromJson(Map<String, dynamic> json) {
  //   return Commit(
  //     sha: json['sha'],
  //     commit: new Commitdetails.fromJson(json['commit']),
  //   );
  // }
}