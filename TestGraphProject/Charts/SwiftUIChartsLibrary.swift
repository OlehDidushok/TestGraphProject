//
//  SwiftUIChartsLibrary.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI
import SwiftUICharts

struct SwiftUIChartsLibraryView: View {
    let chartData: LineChartData
    
    init() {
        let dataSet = LineDataSet(
            dataPoints: [
                LineChartDataPoint(
                    value: MoodCondition.excellent.rawValue,
                    xAxisLabel: WeekDay.monday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.terrible.rawValue,
                    xAxisLabel: WeekDay.tuesday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.good.rawValue,
                    xAxisLabel: WeekDay.wednesday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.terrible.rawValue,
                    xAxisLabel: WeekDay.thursday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.good.rawValue,
                    xAxisLabel: WeekDay.friday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.usual.rawValue,
                    xAxisLabel: WeekDay.saturnday.rawValue.capitalized
                ),
                LineChartDataPoint(
                    value: MoodCondition.excellent.rawValue,
                    xAxisLabel: WeekDay.sunday.rawValue.capitalized
                )
            ],
            pointStyle: PointStyle(
                fillColour: .green,
                pointType: .filled,
                pointShape: .circle
            ),
            style: LineStyle(
                lineColour: ColourStyle(colour: .blue),
                lineType: .line
            )
        )
        
        let gridStyle = GridStyle(
            numberOfLines: 4,
            lineColour: Color(.lightGray).opacity(0.5),
            lineWidth: 1,
            dash: [4],
            dashPhase: 0
        )
        
        let chartStyle = LineChartStyle(
            infoBoxPlacement: .infoBox(isStatic: true),
            xAxisLabelPosition: .bottom,
            xAxisLabelFont: .headline,
            xAxisLabelColour: Color.black,
            yAxisGridStyle: gridStyle,
            yAxisLabelPosition: .leading,
            yAxisLabelFont: .headline,
            yAxisLabelColour: Color.black,
            yAxisNumberOfLabels: 4,
            yAxisLabelType: .custom
        )
        
        self.chartData = LineChartData(
            dataSets: dataSet,
            metadata: ChartMetadata(title: "", subtitle: ""),
            yAxisLabels: MoodCondition.statusList,
            chartStyle: chartStyle
        )
    }
    
    var body: some View {
        LineChart(chartData: chartData)
            .pointMarkers(chartData: chartData)
            .yAxisGrid(chartData: chartData)
            .xAxisLabels(chartData: chartData)
            .yAxisLabels(chartData: chartData)
            .frame(minWidth: 150,
                   maxWidth: 350,
                   minHeight: 100,
                   idealHeight: 150,
                   maxHeight: 200,
                   alignment: .center)
            .padding(.horizontal, 24)
    }
}

#Preview {
    SwiftUIChartsLibraryView()
}
