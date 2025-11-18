import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgas/cubit/card_cubit/card_cubit.dart';
import 'package:pgas/data/model/event_model/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.eventName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildRow('Дата:', event.eventDate),
            _buildRow('Вид деятельности:', event.activityType),
            _buildRow('Статус:', event.achievementStatus),
            _buildRow('Уровень:', event.achievementLevel),
            _buildRow('Документ:', event.documentProof),
            _buildRow(
              'Баллы:',
              '${event.points}',
              valueStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  context.read<CardCubit>().deleteEvent(event.id);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
