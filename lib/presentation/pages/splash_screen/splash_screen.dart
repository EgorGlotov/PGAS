import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>{
  @override 
  void initState(){
    super.initState();
  final authCubit = context.read<AuthCubit>();

    Timer(Duration(seconds: 4),(){
       if (authCubit.currentUser != null) {
        // Пользователь авторизован - идем на домашнюю страницу
        context.go('/home_page');
      } else {
        // Пользователь не авторизован - идем на стартовую страницу
        context.go('/start');
      }
    });
  }
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/пггпу.png', width: 100,height: 100,),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: CircularProgressIndicator(),
            )
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}


