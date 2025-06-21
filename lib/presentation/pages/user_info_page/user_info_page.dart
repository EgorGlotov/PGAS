import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/user_cubit/user_cubit.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);
  static const String path = '/user_info ';

  @override
  State<UserInfoPage> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _surnameController;
  late TextEditingController _nameController;
  late TextEditingController _middleNameController;
  late TextEditingController _groupController;

  @override
  void initState() {
    super.initState();
    final currentUser = context.read<UserCubit>().state;
    _surnameController = TextEditingController(text: currentUser.surname);
    _nameController = TextEditingController(text: currentUser.name);
    _middleNameController = TextEditingController(text: currentUser.middleName);
    _groupController = TextEditingController(text: currentUser.group.toString());
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _nameController.dispose();
    _middleNameController.dispose();
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Редактирование профиля'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Фамилия'),
                validator: (value) => value!.isEmpty ? 'Введите фамилию' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (value) => value!.isEmpty ? 'Введите имя' : null,
              ),
              TextFormField(
                controller: _middleNameController,
                decoration: const InputDecoration(labelText: 'Отчество'),
                validator: (value) => value!.isEmpty ? 'Введите отчество' : null,
              ),
              TextFormField(
                controller: _groupController,
                decoration: const InputDecoration(labelText: 'Группа'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Введите номер группы' : null,
              ),
              ElevatedButton(
                onPressed: () async{
                  _saveProfile();
                  context.go('/home_page'); 
                },
                child: Text('Зарегистрироваться')),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserModel(
        surname: _surnameController.text,
        name: _nameController.text,
        middleName: _middleNameController.text,
        group: int.tryParse(_groupController.text) ?? 0,
      );
      
      context.read<UserCubit>().saveUser(updatedUser);
    }
  }
}