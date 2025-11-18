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
          context.go('/user_info');
        } else if (state is AuthCubitUnauthorized && state.error != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                height: 30,
              ),
              Container(
                height: 55,
                width: 200,
                color: const Color.fromARGB(255, 1, 52, 94),
                child: 
              Row(
                children: [
                  Container(
                    width: 100,
                    child: 
              FloatingActionButton(onPressed: (){
                print(1);
              }, 
              backgroundColor: Color.fromARGB(255, 1, 52, 94),
              child: 
              Text('Sign Up',style: TextStyle(color: Colors.white),))),
              Container(
                width: 100,
                    child: 
              FloatingActionButton(onPressed: (){
                print(1);
              }, 
              backgroundColor: const Color.fromARGB(255, 17, 87, 145),
              child: 
              Text('Sign In', style: TextStyle(color: Colors.white),))),
              ]),),
              Text('Зарегистрироваться', style: TextStyle(color: Color.fromARGB(255, 1, 52, 94), fontSize: 25, fontWeight:  FontWeight.w800),),
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