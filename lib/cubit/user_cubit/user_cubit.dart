import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class UserCubit extends Cubit<UserModel> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  StreamSubscription? _userSubscription;

  UserCubit({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        super(UserModel.empty()) {
    init();
  }

  Future<void> init() async {
    await _loadUser();
    _setupUserListener();
  }

  Future<void> _loadUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(UserModel.empty());
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        emit(UserModel.fromFirestore(doc));
      } else {
        await _createDefaultUser(user.uid);
      }
    } catch (e) {
      emit(UserModel.empty());
      debugPrint('User loading error: $e');
    }
  }

  Future<void> _createDefaultUser(String uid) async {
    final newUser = UserModel.empty();
    await _firestore.collection('users').doc(uid).set(newUser.toFirestore());
    emit(newUser);
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      await _firestore.collection('users')
        .doc(currentUser.uid)
        .set(user.toFirestore(), SetOptions(merge: true));
      
      emit(user);
    } catch (e) {
      debugPrint('User update error: $e');
      rethrow;
    }
  }

  bool isProfileComplete(UserModel user) {
    return user.surname.isNotEmpty && 
           user.name.isNotEmpty && 
           user.group != 0;
  }

  void _setupUserListener() {
    final user = _auth.currentUser;
    if (user == null) return;
    
    _userSubscription = _firestore.collection('users').doc(user.uid)
      .snapshots()
      .listen((doc) {
        if (doc.exists) {
          emit(UserModel.fromFirestore(doc));
        }
      });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}