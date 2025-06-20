// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      eventName: json['eventName'] as String,
      eventDate: json['eventDate'] as String,
      activityType: json['activityType'] as String,
      achievementStatus: json['achievementStatus'] as String,
      achievementLevel: json['achievementLevel'] as String,
      documentProof: json['documentProof'] as String,
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'eventDate': instance.eventDate,
      'activityType': instance.activityType,
      'achievementStatus': instance.achievementStatus,
      'achievementLevel': instance.achievementLevel,
      'documentProof': instance.documentProof,
      'points': instance.points,
    };
