// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'committer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Committer _$CommitterFromJson(Map<String, dynamic> json) {
  return Committer(
    name: json['name'] as String,
    email: json['email'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$CommitterToJson(Committer instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
    };
