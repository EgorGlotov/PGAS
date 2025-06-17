import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pgas/core/router/app_router.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация Hive
  await Hive.initFlutter();
  
  // Регистрация адаптера
  Hive.registerAdapter(CardModelAdapter());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(CardRepository()),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}