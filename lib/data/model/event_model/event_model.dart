import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
@JsonSerializable()
class EventModel with _$EventModel {
  const EventModel._(); // Необходим для кастомных методов

  const factory EventModel({
    required String id,
    required String eventName,
    required String eventDate, // Храним как строку в ISO-формате
    required String activityType,
    required String achievementStatus,
    required String achievementLevel,
    required String documentProof,
    required double points,
  }) = _EventModel;

  // Конструктор из Firestore документа
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      eventName: data['eventName'] as String? ?? '',
      eventDate: data['eventDate'] as String? ?? DateTime.now().toIso8601String(),
      activityType: data['activityType'] as String? ?? '',
      achievementStatus: data['achievementStatus'] as String? ?? '',
      achievementLevel: data['achievementLevel'] as String? ?? '',
      documentProof: data['documentProof'] as String? ?? '',
      points: (data['points'] as double?) ?? 0,
    );
  }

  // Преобразование в Map для Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'eventName': eventName,
      'eventDate': eventDate, // Сохраняем как строку
      'activityType': activityType,
      'achievementStatus': achievementStatus,
      'achievementLevel': achievementLevel,
      'documentProof': documentProof,
      'points': points,
    };
  }

  // Дополнительные методы для удобной работы с датой
  DateTime get parsedDate => DateTime.tryParse(eventDate) ?? DateTime.now();
  String toIsoDate() => parsedDate.toIso8601String();
 
}