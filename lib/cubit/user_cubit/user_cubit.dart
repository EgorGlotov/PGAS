import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel.empty());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Загрузка данных пользователя
  Future<void> loadUser() async {
    final userDoc = await _firestore.collection('users').doc(_auth.currentUser?.uid).get();
    if (userDoc.exists) {
      emit(UserModel.fromFirestore(userDoc));
    }
  }

  // Сохранение данных
  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(_auth.currentUser?.uid).set(user.toFirestore());
    emit(user);
  }
}