import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/presentation/pages/event_card/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Главная страница', style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<CardCubit, CardCubitState>(
        builder: (context, state) {
          if (state is CardCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CardCubitLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.event.length,
              itemBuilder: (ctx, index) => EventCard(event: state.event[index]),
            );
          }
          if (state is CardCubitError) {
            return Center(child: Text('Ошибка: ${state.error}'));
          }
          return const Center(child: Text('Добро пожаловать'));
        },
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
              onPressed: () => _showAddEventDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              iconSize: 50,
              onPressed: () => context.go('/account_page'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final activityController = TextEditingController();
    final statusController = TextEditingController();
    final levelController = TextEditingController();
    final documentController = TextEditingController();
    final pointsController = TextEditingController();
    DateTime? selectedDate;

    Future<void> _selectDate(BuildContext context) async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        selectedDate = picked;
        dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить событие'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Название*'),
                  validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Дата'),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                TextFormField(
                  controller: activityController,
                  decoration: const InputDecoration(labelText: 'Вид деятельности'),
                ),
                TextFormField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: 'Статус'),
                ),
                TextFormField(
                  controller: levelController,
                  decoration: const InputDecoration(labelText: 'Уровень'),
                ),
                TextFormField(
                  controller: documentController,
                  decoration: const InputDecoration(labelText: 'Документ'),
                ),
                TextFormField(
                  controller: pointsController,
                  decoration: const InputDecoration(labelText: 'Баллы'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<CardCubit>().addEvent(
                  eventName: titleController.text,
                  eventDate: selectedDate != null 
                    ? DateFormat('yyyy-MM-dd').format(selectedDate!) 
                    : '',
                  activityType: activityController.text,
                  achievementStatus: statusController.text,
                  achievementLevel: levelController.text,
                  documentProof: documentController.text,
                  points: int.tryParse(pointsController.text) ?? 0,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Событие добавлено')),
                );
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}