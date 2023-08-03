import 'package:flutter/material.dart';
import 'package:flutter_swift_ios_widget/models.dart';
import 'package:flutter_swift_ios_widget/view_models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsWidgets extends StatelessWidget {
  const EventsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: context.watch<EventsViewModel>().eventsList.length,
        itemBuilder: (context, i) => EventCard(event: context.read<EventsViewModel>().eventsList[i]),
      )),
    );
  }
}

class EventCard extends StatelessWidget {
  final WidgetData event;

  const EventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: event.type.eventColor.withOpacity(1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(event.type.eventIcon, size: 35),
                const SizedBox(width: 8),
                Text(
                  "${DateFormat.MMMd().format(event.dayMonth)}, ${event.dayMonth.timeFormatWidget}",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'sub label',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
