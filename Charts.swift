//
//  Charts.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI
import Charts

struct Day: Identifiable {
    let id = UUID()
    let mood: MoodCondition
    let day: WeekDay
}

let currentWeeks: [Day] = [
    Day(mood: .great, day: .mon),
    Day(mood: .soso, day: .tue),
    Day(mood: .fine, day: .wed),
    Day(mood: .soso, day: .thu),
    Day(mood: .fine, day: .fri),
    Day(mood: .normal, day: .sat),
    Day(mood: .great, day: .sun)
]

struct ChartsView: View {
    var body: some View {
        VStack {
            Chart {
                ForEach(currentWeeks) {
                    LineMark(
                        x: .value("Week Day", $0.day.rawValue.capitalized),
                        y: .value("Mood", $0.mood.rawValue))
                    PointMark(
                        x: .value("Week Day", $0.day.rawValue.capitalized),
                        y: .value("Mood", $0.mood.rawValue))
                    .foregroundStyle(.green)
                }
            }
            .chartXAxis {
                AxisMarks(preset: .aligned,
                          position: .bottom) { value in
                    AxisValueLabel()
                        .font(Font.headline)
                        .foregroundStyle(.black)
                }
            }
            .chartYAxis {
                AxisMarks(preset: .aligned,
                          position: .leading) { value in
                    AxisValueLabel {
                        let day = MoodCondition.statusList[value.index]
                        Text(day.capitalized)
                            .font(Font.headline)
                            .foregroundColor(.black)
                    }
                    AxisGridLine(
                        stroke: StrokeStyle(
                            lineWidth: 1,
                            dash: [4]))
                }
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}

struct LineCharts: View {
    var body: some View {
        ChartsView()
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        LineCharts()
    }
}
