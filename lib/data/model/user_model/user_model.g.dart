// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      surname: json['surname'] as String,
      name: json['name'] as String,
      middleName: json['middleName'] as String,
      group: (json['group'] as num).toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'surname': instance.surname,
      'name': instance.name,
      'middleName': instance.middleName,
      'group': instance.group,
    };
