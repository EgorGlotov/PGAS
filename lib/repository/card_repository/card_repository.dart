import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pgas/data/model/event_model/event_model.dart';

class CardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventModel>> getEvents() async {
    final snapshot = await _firestore.collection('events').get();
    return snapshot.docs.map(EventModel.fromFirestore).toList();
  }

  Future<void> addEvent(EventModel event) async {
    await _firestore.collection('events').doc(event.id).set({
      'eventName': event.eventName,
      'eventDate': event.eventDate,
      'activityType': event.activityType,
      'achievementStatus': event.achievementStatus,
      'achievementLevel': event.achievementLevel,
      'documentProof': event.documentProof,
      'points': event.points,
    });
  }

  Future<void> deleteEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).delete();
  }
}