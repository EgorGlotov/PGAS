import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream для отслеживания состояния пользователя
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Вход с email и паролем
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка входа: $e');
      }
      return null;
    }
  }

  // Регистрация
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка регистрации: $e');
      }
      return null;
    }
  }

  // Выход
  Future<void> signOut() async {
    await _auth.signOut();
  }
}