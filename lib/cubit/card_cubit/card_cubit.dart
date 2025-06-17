import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';

class CardCubit extends Cubit<CardCubitState> {
  final CardRepository _repository;

  CardCubit(this._repository) : super(CardCubitInitial());

  Future<void> loadEvent() async {
    emit(CardCubitLoading());
    try {
      final List<CardModel> events = await _repository.getEvent(); // Указан тип
      emit(CardCubitLoaded(events)); // Исправлена скобка
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> addEvent(String title, String description) async {
    try {
      final newEvent = CardModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
      );
      await _repository.addEvent(newEvent);
      await loadEvent();
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> changeEventStatus(CardModel event) async { // Исправлено имя параметра
    try {
      final updatedEvent = CardModel(
        id: event.id,
        title: event.title,
        description: event.description,
      );
      await _repository.updateEvent(updatedEvent);
      await loadEvent();
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _repository.deleteEvent(eventId);
      await loadEvent();
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }
}