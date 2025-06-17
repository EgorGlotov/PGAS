import 'package:pgas/data/model/event_model/event_model.dart';

abstract class CardCubitState {}

class CardCubitInitial extends CardCubitState {}

class CardCubitLoading extends CardCubitState {}

class CardCubitLoaded extends CardCubitState {
  final List<CardModel> event;

  CardCubitLoaded(this.event);
}

class CardCubitError extends CardCubitState {
  final String error;

  CardCubitError(this.error);
}