// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String,
      eventName: json['eventName'] as String,
      eventDate: json['eventDate'] as String,
      activityType: json['activityType'] as String,
      achievementStatus: json['achievementStatus'] as String,
      achievementLevel: json['achievementLevel'] as String,
      documentProof: json['documentProof'] as String,
      points: (json['points'] as num).toDouble(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
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
