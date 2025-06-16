import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Главная страница', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Text('Добро пожаловать',
        style: TextStyle(fontSize: 24),),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.save_alt, color: Colors.white,),
              onPressed: () {
                print('скачать');
              },
            ),
             IconButton(
              icon: Icon(Icons.add_circle, color: Colors.amber,),
              onPressed: () {
                print('добавить');
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.amber,),
              onPressed: () {
                print('аккаунт');
              },
            )
          ],
        ),
      ),
    );
  }
}