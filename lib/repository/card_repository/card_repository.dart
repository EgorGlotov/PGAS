import 'package:hive/hive.dart';
import 'package:pgas/data/model/event_model/event_model.dart';

class CardRepository {
  static const String _boxName = 'eventsBox';

  Future<Box<CardModel>> get _box async {
    return await Hive.openBox<CardModel>(_boxName);
  }

  Future<List<CardModel>> getEvent() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> addEvent(CardModel event) async {
    final box = await _box;
    await box.put(event.id, event);
  }

  Future<void> updateEvent(CardModel updatedEvent) async {
    final box = await _box;
    await box.put(updatedEvent.id, updatedEvent);
  }

  Future<void> deleteEvent(String eventId) async {
    final box = await _box;
    await box.delete(eventId);
  }
}