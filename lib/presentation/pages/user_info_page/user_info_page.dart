import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/user_cubit/user_cubit.dart';
import 'package:pgas/data/model/user_model/user_model.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _surnameController;
  late final TextEditingController _nameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _groupController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state;
    _surnameController = TextEditingController(text: user.surname);
    _nameController = TextEditingController(text: user.name);
    _middleNameController = TextEditingController(text: user.middleName);
    _groupController = TextEditingController(
      text: user.group != 0 ? user.group.toString() : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование профиля'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_surnameController, 'Фамилия*', true),
              _buildTextField(_nameController, 'Имя*', true),
              _buildTextField(_middleNameController, 'Отчество', false),
              _buildNumberField(_groupController, 'Группа*'),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.indigo,
                ),
                onPressed: _saveProfile,
                child: const Text('СОХРАНИТЬ ПРОФИЛЬ', 
                  style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String label, 
    bool required
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required 
            ? (value) => value!.isEmpty ? 'Обязательное поле' : null
            : null,
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Введите номер группы';
          if (int.tryParse(value) == null) return 'Некорректный номер';
          return null;
        },
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserModel(
        surname: _surnameController.text,
        name: _nameController.text,
        middleName: _middleNameController.text,
        group: int.tryParse(_groupController.text) ?? 0,
      );
      
      await context.read<UserCubit>().updateUser(updatedUser);
      if (mounted) context.go('/home_page');
    }
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _nameController.dispose();
    _middleNameController.dispose();
    _groupController.dispose();
    super.dispose();
  }
}