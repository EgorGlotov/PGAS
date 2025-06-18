import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';
import 'package:uuid/uuid.dart';

class CardCubit extends Cubit<CardCubitState> {
  final CardRepository _repository;
  final Uuid _uuid = const Uuid();

  CardCubit(this._repository) : super(CardCubitInitial()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    emit(CardCubitLoading());
    try {
      final events = await _repository.getEvents();
      emit(CardCubitLoaded(events));
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> addEvent({
    required String eventName,
    required String eventDate,
    required String activityType,
    required String achievementStatus,
    required String achievementLevel,
    required String documentProof,
    required int points,
  }) async {
    try {
      final newEvent = EventModel(
        id: _uuid.v4(),
        eventName: eventName,
        eventDate: eventDate,
        activityType: activityType,
        achievementStatus: achievementStatus,
        achievementLevel: achievementLevel,
        documentProof: documentProof,
        points: points,
      );
      await _repository.addEvent(newEvent);
      await loadEvents();
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _repository.deleteEvent(eventId);
      await loadEvents();
    } catch (e) {
      emit(CardCubitError(e.toString()));
    }
  }
}