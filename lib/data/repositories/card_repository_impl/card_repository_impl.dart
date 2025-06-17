import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final List<CardModel> _storage = [];

  @override
  Future<List<CardModel>> getEvent() async => _storage;

  @override
  Future<void> addEvent(CardModel event) async => _storage.add(event);

  @override
  Future<void> updateEvent(CardModel updatedEvent) async {
    final index = _storage.indexWhere((e) => e.id == updatedEvent.id);
    if (index != -1) _storage[index] = updatedEvent;
  }

  @override
  Future<void> deleteEvent(String eventId) async => 
      _storage.removeWhere((e) => e.id == eventId);
}