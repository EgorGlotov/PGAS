import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/core/router/app_router.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/repository/card_repository/card_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => CardCubit(CardRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
@override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) => CardCubit(
            CardRepository(
              auth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          )..loadEvents(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}