// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitDetails _$CommitDetailsFromJson(Map<String, dynamic> json) {
  return CommitDetails(
    message: json['message'] as String,
    committer: json['committer'] == null
        ? null
        : Committer.fromJson(json['committer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommitDetailsToJson(CommitDetails instance) =>
    <String, dynamic>{
      'message': instance.message,
      'committer': instance.committer?.toJson(),
    };
