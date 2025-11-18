import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pgas/data/model/event_model/event_model.dart';

class CardRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CardRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<List<EventModel>> getEvents() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .get();

      return snapshot.docs
          .map((doc) => EventModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load events: ${e.toString()}');
    }
  }

  Future<void> addEvent(EventModel event) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .doc(event.id)
          .set(event.toFirestore());
    } catch (e) {
      throw Exception('Failed to add event: ${e.toString()}');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('events')
          .doc(eventId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete event: ${e.toString()}');
    }
  }
}