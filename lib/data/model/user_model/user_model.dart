import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@JsonSerializable()
class UserModel with _$UserModel{
  const UserModel._();

  const factory UserModel({
    required String surname,
    required String name,
    required String middleName,
    required int group,
  }) =_UserModel;

  factory UserModel.empty() => const UserModel(
        surname: '',
        name: '',
        middleName: '',
        group: 0,
      );
  
  factory UserModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      surname: data['surname'] as String? ?? '',
      name: data['name'] as String? ?? '',
      middleName: data['middleName'] as String? ?? '',
      group: data['group'] as int? ?? 0,
    );
  }

  Map<String, dynamic>toFirestore(){
    return{
      'surname': surname,
      'name': name,
      'middleName': middleName,
      'group': group,
    };
  }
}