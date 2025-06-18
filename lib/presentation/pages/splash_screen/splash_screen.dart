import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override 
  void initState(){
    super.initState();

    Timer(Duration(seconds: 10),(){
      context.go('/home_page');
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


