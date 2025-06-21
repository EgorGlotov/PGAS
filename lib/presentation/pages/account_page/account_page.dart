import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/cubit/user_cubit/user_cubit.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserModel>(
      listener: (context, user) {
        final isComplete = context.read<UserCubit>().isProfileComplete(user);
        if (!isComplete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/user_info');
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ваш профиль', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
        body: const _ProfileContent(),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await context.read<AuthCubit>().signOut();
      if (context.mounted) context.go('/start');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка выхода: ${e.toString()}')),
        );
      }
    }
  }

  BottomAppBar _buildBottomBar(BuildContext context) {
    return BottomAppBar(
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
            icon: const Icon(Icons.home, color: Colors.white),
            iconSize: 50,
            onPressed: () => context.go('/home_page'),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            iconSize: 50,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final isComplete = context.read<UserCubit>().isProfileComplete(user);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileField('Фамилия', user.surname),
          _buildProfileField('Имя', user.name),
          _buildProfileField('Отчество', user.middleName),
          _buildProfileField('Группа', user.group.toString()),
          if (!isComplete) const SizedBox(height: 20),
          if (!isComplete) ElevatedButton(
            onPressed: () => context.go('/user_info'),
            child: const Text('Заполнить профиль'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
          Text(value.isEmpty ? 'Не указано' : value, style: const TextStyle(
            fontSize: 18,
          )),
          const Divider(),
        ],
      ),
    );
  }
}