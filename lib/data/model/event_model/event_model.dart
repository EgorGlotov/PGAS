import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
@JsonSerializable()
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String eventName,
    required String eventDate,
    required String activityType,
    required String achievementStatus,
    required String achievementLevel,
    required String documentProof,
    required int points,
  }) = _EventModel;

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      eventName: data['eventName'] ?? '',
      eventDate: data['eventDate'] ?? '',
      activityType: data['activityType'] ?? 'КТ',
      achievementStatus: data['achievementStatus'] ?? '',
      achievementLevel: data['achievementLevel'] ?? '',
      documentProof: data['documentProof'] ?? '',
      points: data['points'] ?? 0,
    );
  }
}