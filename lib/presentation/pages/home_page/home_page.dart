import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/presentation/pages/event_card/event_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardCubit = BlocProvider.of<CardCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Главная страница', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<CardCubit, CardCubitState>(
        builder: (context, state) {
          if (state is CardCubitLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CardCubitLoaded) {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.event.length,
              itemBuilder: (ctx, index) => EventCard(event: state.event[index]),
            );
          }
          if (state is CardCubitError) {
            return Center(child: Text('Ошибка: ${state.error}'));
          }
          return Center(child: Text('Добро пожаловать'));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.save_alt, color: Colors.white),
              iconSize: 50,
              onPressed: () => cardCubit.loadEvent(),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white),
              iconSize: 50,
              onPressed: () => _showAddEventDialog(context),
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              iconSize: 50,
              onPressed: () => context.go('/account_page'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final cardCubit = BlocProvider.of<CardCubit>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить событие'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Описание'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                cardCubit.addEvent(
                  titleController.text,
                  descriptionController.text,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Событие добавлено')),
                );
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}