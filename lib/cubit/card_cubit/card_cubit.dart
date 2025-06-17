import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';
import 'package:uuid/uuid.dart';

class CardCubit extends Cubit<CardCubitState> {
  final CardRepository _repository;

  CardCubit(this._repository) : super(CardCubitInitial()) {
    loadEvent(); // Автоматическая загрузка при создании
  }

  Future<void> loadEvent() async {
    emit(CardCubitLoading());
    try {
      final events = await _repository.getEvent();
      emit(CardCubitLoaded(events));
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> addEvent(String title, String description) async {
  try {
    final newEvent = CardModel(
      id: const Uuid().v4(), // Генерация UUID вместо временной метки
      title: title,
      description: description,
    );
    await _repository.addEvent(newEvent);
    await loadEvent();
  } catch (e) {
    emit(CardCubitError(e.toString()));
  }
}

  Future<void> changeEventStatus(CardModel event) async {
    try {
      await _repository.updateEvent(event);
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