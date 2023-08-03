import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swift_ios_widget/models.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';

const iOSGroupOld = 'group.flutterswiftioswidget';
const iOSGroup = 'group.next.event.widget';
const parsedStrForIOS = 'widgetData';

class EventsViewModel extends ChangeNotifier {
  final eventsList = <WidgetData>[
    WidgetData(name: "Meeting event", dayMonth: DateTime.now().add(const Duration(days: 4)), type: EventType.meeting),
    WidgetData(name: "Call event", dayMonth: DateTime.now().add(const Duration(days: 2)), type: EventType.call),
    WidgetData(
        name: "Conference event", dayMonth: DateTime.now().add(const Duration(days: 6)), type: EventType.conference),
  ];

  WidgetData getFirstUpcomingEvent() {
    List<WidgetData> sortedEventsList = List.from(eventsList);
    sortedEventsList.sort((a, b) => a.dayMonth.compareTo(b.dayMonth));
    return sortedEventsList.first;
  }

  setNewEvent() {
    eventsList.add(getRandomEvent());
    notifyListeners();

    setIOSDataWidget();
  }

  setIOSDataWidget() {
    WidgetKit.setItem(parsedStrForIOS, getFirstUpcomingEvent().passJsonToNative(), iOSGroup);
    WidgetKit.reloadAllTimelines();
  }
}

WidgetData getRandomEvent() {
  final randomNum = Random().nextInt(3);

  switch (randomNum) {
    case 0:
      return WidgetData(
        name: "Call event",
        dayMonth: DateTime.now().add(const Duration(days: 1)),
        type: EventType.call,
      );
    case 1:
      return WidgetData(
        name: "Meeting event",
        dayMonth: DateTime.now().add(const Duration(days: 1)),
        type: EventType.meeting,
      );
    case 2:
      return WidgetData(
        name: "Conference event",
        dayMonth: DateTime.now().add(const Duration(days: 1)),
        type: EventType.conference,
      );
    default:
      return WidgetData(
        name: "None event",
        dayMonth: DateTime.now().add(const Duration(days: 1)),
        type: EventType.none,
      );
  }
}
