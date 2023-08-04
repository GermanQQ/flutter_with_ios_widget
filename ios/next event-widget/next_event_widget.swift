//
//  next_event_widget.swift
//  next event-widget
//
//  Created by Worker Laptop on 03.08.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    //If you don't have any data
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(dayMonth: "--/--", time: "--:-- AM", type: "none"))
    }
    
    //Current state of widget preview in galery to see how widget look with user data
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (FlutterEntry) -> ()) {
        let entry = FlutterEntry(date: Date(), configuration: configuration, widgetData: WidgetData(dayMonth: "30/04", time: "10:30 AM", type: "meeting"))
        completion(entry)
    }
    
    //All data widget
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let sharedDefaults = UserDefaults.init(suiteName: "group.next.event.widget")
        let flutterData = try? JSONDecoder().decode(WidgetData.self, from: (sharedDefaults?
            .string(forKey: "widgetData")?.data(using: .utf8)) ?? Data())
        
        let currentDate = Date()
        let entry = FlutterEntry(date: currentDate, configuration: configuration, widgetData: flutterData ?? WidgetData(dayMonth: "-/-"))
      
        //Reload policy Creates a timeline for when you want WidgetKit to update a widget’s view.
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct FlutterEntry: TimelineEntry {
    //date for follow TimelineEntry protocoll, to when to update widget
    //but for flutter case we don't need it, becouse we update widget from flutter
    let date: Date
    let configuration: ConfigurationIntent
    
    let widgetData: WidgetData
}

//Main entry point
struct next_event_widget: Widget {
    let kind: String = "next_event_widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            next_event_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        // supportedFamilies is supported widget size
        .supportedFamilies([.systemSmall])
    }
}

struct next_event_widget_Previews: PreviewProvider {
    static var previews: some View {
        next_event_widgetEntryView(entry: FlutterEntry(date: Date(), configuration: ConfigurationIntent() , widgetData: WidgetData(dayMonth: Date().dayDisplayFormat, time: "12:12 AM", type: "conference")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

//View Ui
struct next_event_widgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            ContainerRelativeShape().fill(getCollorByType(type: entry.widgetData.type))
            VStack{
                HStack{
                    Text(getEmojiByType(type: entry.widgetData.type)).font(.title2)
                    Text(entry.widgetData.time).font(.title3).fontWeight(.bold).minimumScaleFactor(0.6).foregroundColor(.black.opacity(0.6))
                }
                Spacer()
                Text(entry.widgetData.dayMonth).font(.system(size: 40, weight: .heavy)).foregroundColor(.white.opacity(0.8))
                Spacer()
            }.padding()
        }
    }
}

//Data models
struct WidgetData: Decodable, Hashable {
    let dayMonth: String
    var time: String = "--:--"
    var type: String = "none"
    var name: String = "none"
}

extension Date {
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day()) + "/" + self.formatted(.dateTime.month(.defaultDigits))
    }
}

func getCollorByType(type: String) -> AnyGradient {
    switch (type){
    case "call":
        return Color.purple.gradient
    case "meeting":
        return Color.indigo.gradient
    case "conference":
        return Color.green.gradient
    default:
        return Color.gray.gradient
    }
}

func getEmojiByType(type: String) -> String {
    switch (type){
    case "call":
        return "📞"
    case "meeting":
        return "🤝🏻"
    case "conference":
        return "🎤"
    default:
        return ""
    }
}
