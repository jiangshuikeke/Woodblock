//
//  WoodblockWidget.swift
//  WoodblockWidget
//
//  Created by 陈沈杰 on 2022/12/7.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(),index: 0)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration,index: 0)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let index = GroupManager.shared.styleIndex
        let entry = SimpleEntry(date: currentDate, configuration: configuration, index: index)
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let index:Int
}

struct WoodblockWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            styles[entry.index].image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(styles[entry.index].backgroundColor)
    }
}

@main
struct WoodblockWidget: Widget {
    let kind: String = "WoodenFish"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WoodblockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("木鱼小组件")
        .supportedFamilies([.systemSmall,.systemLarge,.systemMedium])
    }
}

struct WoodblockWidget_Previews: PreviewProvider {
    static var previews: some View {
        WoodblockWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(),index: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
