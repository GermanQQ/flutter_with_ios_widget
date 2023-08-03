import 'package:flutter/material.dart';
import 'package:flutter_swift_ios_widget/events_page.dart';
import 'package:flutter_swift_ios_widget/view_models.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(home: TextPage()));
}

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  TextPageState createState() => TextPageState();
}

class TextPageState extends State<TextPage> {
  final model = EventsViewModel();
  @override
  void initState() {
    model.setIOSDataWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsViewModel>(
      create: (context) => model,
      builder: (context, child) => Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: EventsWidgets()),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addNewEvent,
                  child: const Text("Add new event"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addNewEvent() {
    model.setNewEvent();
  }
}
