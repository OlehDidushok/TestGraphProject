//
//  Charts.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI
import Charts

struct Days: Identifiable {
    let id = UUID()
    let mood: MoodCondition
    let day: WeekDay
}

let currentWeeks: [Days] = [
    Days(mood: .great, day: .mon),
    Days(mood: .soso, day: .tue),
    Days(mood: .fine, day: .wed),
    Days(mood: .soso, day: .thu),
    Days(mood: .fine, day: .fri),
    Days(mood: .normal, day: .sat),
    Days(mood: .great, day: .sun)
]

struct ContentViews: View {
    
    var body: some View {
        VStack {
            Chart {
                ForEach(currentWeeks) {
                    LineMark(
                        x: .value("Week Day", $0.day.rawValue.capitalized),
                        y: .value("Mood", $0.mood.rawValue)
                    )

                    PointMark(
                        x: .value("Week Day", $0.day.rawValue.capitalized),
                        y: .value("Mood", $0.mood.rawValue)
                    )
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
                            dash: [4]
                        ))
                }
            }
        }
        .frame(height: 300)
        .padding(.horizontal)
    }
}

struct LineCharts: View {
    var body: some View {
        ContentViews()
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        LineCharts()
    }
}
