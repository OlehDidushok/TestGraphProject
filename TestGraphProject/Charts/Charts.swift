//
//  Charts.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI
import Charts

struct ChartsView: View {
    struct Day: Identifiable {
        let id = UUID()
        let mood: MoodCondition
        let day: WeekDay
    }

    let currentWeeks: [Day] = [
        Day(mood: .excellent, day: .monday),
        Day(mood: .terrible, day: .tuesday),
        Day(mood: .good, day: .wednesday),
        Day(mood: .terrible, day: .thursday),
        Day(mood: .good, day: .friday),
        Day(mood: .usual, day: .saturnday),
        Day(mood: .excellent, day: .sunday)
    ]
    
    private let weekDayTitle = "Week Day"
    private let moodTitle = "Mood"
    
    var body: some View {
        VStack {
            Chart {
                ForEach(currentWeeks) {
                    LineMark(
                        x: .value(weekDayTitle, $0.day.rawValue.capitalized),
                        y: .value(moodTitle, $0.mood.rawValue)
                    )
                    PointMark(
                        x: .value(weekDayTitle, $0.day.rawValue.capitalized),
                        y: .value(moodTitle, $0.mood.rawValue)
                    )
                    .foregroundStyle(.green)
                }
            }
            .chartXAxis {
                AxisMarks(preset: .aligned,
                          position: .bottom
                ) { value in
                    AxisValueLabel()
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
            .chartYAxis {
                AxisMarks(preset: .aligned,
                          position: .leading) { value in
                    AxisValueLabel {
                        let day = MoodCondition.statusList[value.index]
                        Text(day.capitalized)
                            .font(.headline)
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

#Preview {
    ChartsView()
}
