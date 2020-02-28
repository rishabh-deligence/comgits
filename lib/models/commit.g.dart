// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commit _$CommitFromJson(Map<String, dynamic> json) {
  return Commit(
    sha: json['sha'] as String,
    commit: json['commit'] == null
        ? null
        : CommitDetails.fromJson(json['commit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
      'sha': instance.sha,
      'commit': instance.commit?.toJson(),
    };
