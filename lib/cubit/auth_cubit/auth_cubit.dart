import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final FirebaseAuth _firebaseAuth;
  Stream<User?>? _userStream;

  AuthCubit(this._firebaseAuth) : super(AuthCubitInitial()) {
    // Инициализация потока при создании кубита
    _userStream = _firebaseAuth.authStateChanges();
    _userStream?.listen((User? user) {
      if (user == null) {
        emit(AuthCubitUnauthorized());
      } else {
        emit(AuthCubitAuthorized(user: user));
      }
    });
  }

  // Получение текущего пользователя
  User? get currentUser => _firebaseAuth.currentUser;

  // Поток для отслеживания состояния аутентификации
  Stream<User?> get userStream => _userStream ?? const Stream.empty();

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthCubitLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCubitAuthorized(user: userCredential.user!));
    } catch (e) {
      emit(AuthCubitUnauthorized(error: e.toString()));
      rethrow; // Можно пробросить исключение дальше
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthCubitLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCubitAuthorized(user: userCredential.user!));
    } catch (e) {
      emit(AuthCubitUnauthorized(error: e.toString()));
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    emit(AuthCubitUnauthorized());
  }
}