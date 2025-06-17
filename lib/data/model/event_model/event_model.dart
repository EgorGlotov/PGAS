import 'package:hive/hive.dart';
import 'package:pgas/domain/entities/card_entities/card_entities.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class CardModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;

  CardModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory CardModel.fromEntity(CardEntity entity) {
    return CardModel(
      id: entity.id, 
      title: entity.title, 
      description: entity.description
    );
  }

  CardEntity toEntity() {
    return CardEntity(
      id: id, 
      title: title, 
      description: description
    );
  }
}