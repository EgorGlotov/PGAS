import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';

class SplashScreensGate extends StatefulWidget {
  const SplashScreensGate({super.key});

  @override
  State<SplashScreensGate> createState() => _SplashScreensGateState();
}

class _SplashScreensGateState extends State<SplashScreensGate> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      context.read<AuthCubit>().currentUser != null
          ? context.go("/home_page")
          : context.go('/start');
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

