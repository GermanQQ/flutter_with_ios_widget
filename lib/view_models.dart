import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swift_ios_widget/models.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';

const iOSGroup = 'group.next.event.widget';
const parsedStrForIOS = 'widgetData';

class EventsViewModel extends ChangeNotifier {
  // late Timer timer;

  final eventsList = <WidgetData>[
    WidgetData(name: "Meeting event", dayMonth: DateTime.now().add(const Duration(days: 4)), type: EventType.meeting),
    WidgetData(name: "Call event", dayMonth: DateTime.now().add(const Duration(days: 2)), type: EventType.call),
    WidgetData(
        name: "Conference event", dayMonth: DateTime.now().add(const Duration(days: 6)), type: EventType.conference),
  ];

  WidgetData? getFirstUpcomingEvent() {
    if (eventsList.isEmpty) return null;
    List<WidgetData> sortedEventsList = List.from(eventsList);
    sortedEventsList.sort((a, b) => a.dayMonth.compareTo(b.dayMonth));
    return sortedEventsList.first;
  }

  setNewEvent() {
    final event = getFirstUpcomingEvent();
    if (event != null) eventsList.add(getRandomNewCommingEvent(event));
    notifyListeners();

    setIOSDataWidget();
  }

  setIOSDataWidget() {
    final event = getFirstUpcomingEvent();
    if (event == null) return;
    WidgetKit.setItem(parsedStrForIOS, event.passJsonToNative(), iOSGroup);
    WidgetKit.reloadAllTimelines();
  }

  // void _startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     // DateTime now = DateTime.now();
  //     eventsList.add(getRandomNewCommingEvent(getFirstUpcomingEvent()));
  //     // A new minute has started, trigger your function here
  //     setIOSDataWidget();
  //     notifyListeners();
  //   });
  // }
}

WidgetData getRandomNewCommingEvent(WidgetData prevEvent) {
  final randomNum = Random().nextInt(3);

  switch (randomNum) {
    case 0:
      return WidgetData(
        name: "Call event",
        dayMonth: prevEvent.dayMonth.subtract(const Duration(hours: 1)),
        type: EventType.call,
      );
    case 1:
      return WidgetData(
        name: "Meeting event",
        dayMonth: prevEvent.dayMonth.subtract(const Duration(hours: 1)),
        type: EventType.meeting,
      );
    case 2:
      return WidgetData(
        name: "Conference event",
        dayMonth: prevEvent.dayMonth.subtract(const Duration(hours: 1)),
        type: EventType.conference,
      );
    default:
      return WidgetData(
        name: "None event",
        dayMonth: prevEvent.dayMonth.subtract(const Duration(hours: 1)),
        type: EventType.none,
      );
  }
}
