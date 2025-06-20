import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartPage extends StatelessWidget{
  const StartPage({super.key});
  static const String path = '/start ';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('ПГАС'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/reg'), 
              child: Text('Зарегистрироваться')),
            ElevatedButton(
              onPressed: () => context.go('/auth'), 
              child: Text('Войти'))
          ],
        ),
      ),
    );
  }
}