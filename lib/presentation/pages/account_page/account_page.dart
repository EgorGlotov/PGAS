import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Ваш аккаунт', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Text('Информация пользователя', style: TextStyle(fontSize: 24),),
      ),
            bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.save_alt, color: Colors.white,),
              iconSize: 50,
              onPressed: () {
                print('скачать');
              },
            ),
             IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white,),
              iconSize: 50,
              onPressed: () {
                context.go('/home_page');
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white,),
              iconSize: 50,
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