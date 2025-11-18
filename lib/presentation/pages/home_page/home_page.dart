import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/cubit/card_cubit/card_cubit_state.dart';
import 'package:pgas/data/model/event_model/event_model.dart';
import 'package:pgas/presentation/pages/event_card/event_card.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String path = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Если JSON ещё не загружен — загружаем (удобно, если main() не загрузил заранее)
    if (AchievementService.data.isEmpty) {
      AchievementService.loadPointsJson().then((_) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Главная страница',
          style: TextStyle(color: Colors.white),
        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(context),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ), bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.save_alt, color: Colors.white),
            iconSize: 50,
            onPressed: () => context.go('/pdf_page'),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            iconSize: 50,
            onPressed: () => context.go('/home_page'),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
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
    final documentController = TextEditingController();

    DateTime? selectedDate;

    String? selectedSphere;
    String? selectedLevel;
    String? selectedStatus;
    double points = 0;

    final data = AchievementService.data; // Map<String, dynamic>

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
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void refreshPoints() {
            if (selectedSphere != null &&
                selectedLevel != null &&
                selectedStatus != null) {
              points = AchievementService.getPoints(
                selectedSphere!,
                selectedLevel!,
                selectedStatus!,
              );
            } else {
              points = 0;
            }
            setState(() {});
          }

          // helper getters for dropdown items
          List<String> getSpheres() {
            return data.keys.map((e) => e.toString()).toList();
          }

          List<String> getLevels() {
            if (selectedSphere == null) return [];
            final m = data[selectedSphere] as Map<String, dynamic>?;
            if (m == null) return [];
            return m.keys.map((e) => e.toString()).toList();
          }

          List<String> getStatuses() {
            if (selectedSphere == null || selectedLevel == null) return [];
            final levels = data[selectedSphere] as Map<String, dynamic>?;
            if (levels == null) return [];
            final statuses = levels[selectedLevel] as Map<String, dynamic>?;
            if (statuses == null) return [];
            return statuses.keys.map((e) => e.toString()).toList();
          }

          return AlertDialog(
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
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Обязательное поле' : null,
                    ),

                    TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(labelText: 'Дата'),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),

                    const SizedBox(height: 8),

                    // Сфера (вид деятельности)
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Вид деятельности'),
                      value: selectedSphere,
                      items: getSpheres()
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSphere = value;
                          // сбрасываем зависимые поля
                          selectedLevel = null;
                          selectedStatus = null;
                          points = 0;
                        });
                      },
                      validator: (v) => v == null || v.isEmpty ? 'Выберите сферу' : null,
                    ),

                    const SizedBox(height: 8),

                    // Уровень — зависит от выбранной сферы
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Уровень'),
                      value: selectedLevel,
                      items: getLevels()
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value;
                          selectedStatus = null;
                          points = 0;
                        });
                      },
                      validator: (v) => v == null || v.isEmpty ? 'Выберите уровень' : null,
                    ),

                    const SizedBox(height: 8),

                    // Статус — зависит от уровня
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Статус'),
                      value: selectedStatus,
                      items: getStatuses()
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                        refreshPoints();
                      },
                      validator: (v) => v == null || v.isEmpty ? 'Выберите статус' : null,
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: documentController,
                      decoration: const InputDecoration(labelText: 'Документ'),
                    ),

                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Баллы: $points',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    // отправляем в Cubit
                    context.read<CardCubit>().addEvent(
                          eventName: titleController.text,
                          eventDate: selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : '',
                          activityType: selectedSphere ?? '',
                          achievementLevel: selectedLevel ?? '',
                          achievementStatus: selectedStatus ?? '',
                          documentProof: documentController.text,
                          points: points,
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
          );
        },
      ),
    );
  }
}

// Сервис для расчёта баллов
class AchievementService {
  static Map<String, dynamic> _pointsMap = {};

  static Map<String, dynamic> get data => _pointsMap;

  // Загружаем JSON (вызывается в main() или лениво в HomePage)
  static Future<void> loadPointsJson() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/achievements.json');
      final decoded = json.decode(jsonString);
      if (decoded is Map<String, dynamic>) {
        _pointsMap = decoded;
      } else {
        // Если JSON — список, преобразуем в Map по комбинациям (редко нужно)
        _pointsMap = {};
      }
    } catch (e) {
      // логируем, но не падаем
      debugPrint('Ошибка загрузки achievements.json: $e');
      _pointsMap = {};
    }
  }

  // Получаем баллы по трём параметрам
  static double getPoints(String sphere, String level, String status) {
    try {
      if (_pointsMap.isEmpty) return 0;

      final activityMap = _pointsMap[sphere] as Map<String, dynamic>?;
      if (activityMap == null) return 0;

      final levelMap = activityMap[level] as Map<String, dynamic>?;
      if (levelMap == null) return 0;

      final value = levelMap[status];
      if (value == null) return 0;

      return double.tryParse(value.toString()) ?? 0;
    } catch (e) {
      debugPrint('Ошибка getPoints: $e');
      return 0;
    }
  }
}
