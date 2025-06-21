import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/cubit/user_cubit/user_cubit.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    // Загружаем данные один раз при инициализации
    context.read<UserCubit>().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(
      builder: (context, user) {
        if (user.surname.isEmpty && user.name.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ваш аккаунт', style: TextStyle(color: Colors.white) ),
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () async{
                  _signOut();
                  context.go('/splash_screen');
                } 
                )
            ],
            ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Фамилия: ${user.surname}'),
                Text('Имя: ${user.name}'),
                Text('Отечество: ${user.middleName}'),
                Text('Группа: ${user.group}'),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.save_alt, color: Colors.white),
              iconSize: 50,
              onPressed: () => context.read<CardCubit>().loadEvents(),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.white),
              iconSize: 50,
              onPressed: () => context.go('/home_page'),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              iconSize: 50,
              onPressed: () => Text('account'),
            ),
          ],
        ),
      ),
        );
      },
    );
  }
    Future<void> _signOut() async {
    try {
      await context.read<AuthCubit>().signOut();
      if (mounted) {
        context.go('/start');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при выходе: ${e.toString()}')),
        );
      }
    }
  }
}
