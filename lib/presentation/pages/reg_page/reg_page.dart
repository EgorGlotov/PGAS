import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit_state.dart';
import 'package:pgas/cubit/auth_cubit/auth_cubit.dart';
import 'package:pgas/presentation/pages/log_page/log_page.dart';

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);
  static const String path = '/reg';

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AuthCubitAuthorized) {
          context.go('/home_page');
        } else if (state is AuthCubitUnauthorized && state.error != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 226, 33, 243),
          actions: [
            TextButton(
                onPressed: () {
                  context.go(AuthPage.path);
                },
                style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Цвет текста
               ),
                child: const Text('Log in'))
                
          ],
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Password')),
              ),
              ElevatedButton(onPressed: () {
                context.read<AuthCubit>().signUp(
                    email: emailController.text,
                    password: passwordController.text);
              }, child: BlocBuilder<AuthCubit, AuthCubitState>(
                builder: (context, state) {
                  if (state is AuthCubitLoading) {
                    return const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Text('Register');
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}