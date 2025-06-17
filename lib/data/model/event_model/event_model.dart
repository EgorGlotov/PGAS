import 'package:pgas/domain/entities/card_entities/card_entities.dart';

class CardModel {
  final String id;
  final String title;
  final String description;

  CardModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory CardModel.fromEntity(CardEntity entity) {
    return CardModel(id: entity.id, title: entity.title, description: entity.description);
  }

  CardEntity toEntity() {
    return CardEntity(id: id, title: title, description: description);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      title: map['title'],
      description: map['description']
    );
  }
}