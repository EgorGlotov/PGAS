import 'package:pgas/data/model/event_model/event_model.dart';

class CardRepository {
  final List<CardModel> _event = [];

  // Получение всех задач (как Future)
  Future<List<CardModel>> getEvent() async {
    return Future.value(_event);
  }

  // Добавление новой задачи
  Future<void> addEvent(CardModel event) async {
    _event.add(event);
  }

  // Обновление задачи
  Future<void> updateEvent(CardModel updatedEvent) async {
    final index = _event.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      _event[index] = updatedEvent;
    }
  }

  // Удаление задачи
  Future<void> deleteEvent(String eventId) async {
    _event.removeWhere((event) => event.id == eventId);
  }
}