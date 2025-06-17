import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/core/router/app_router.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';

void main() {
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

