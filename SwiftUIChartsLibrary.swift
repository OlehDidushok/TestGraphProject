//
//  SwiftUIChartsLibrary.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI
import SwiftUICharts

struct SwiftUIChartsLibraryView: View {
    let data: LineChartData = weekOfData()
    var body: some View {
        LineChart(chartData: data)
            .pointMarkers(chartData: data)
            .yAxisGrid(chartData: data)
            .xAxisLabels(chartData: data)
            .yAxisLabels(chartData: data)
            .frame(minWidth: 150, maxWidth: 350, minHeight: 100, idealHeight: 150, maxHeight: 200, alignment: .center)
            .padding(.horizontal, 24)
    }
    
    static func weekOfData() -> LineChartData {
        let data = LineDataSet(dataPoints: [
            LineChartDataPoint(value: MoodCondition.excellent.rawValue, xAxisLabel: WeekDay.mon.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.terrible.rawValue, xAxisLabel: WeekDay.tue.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.good.rawValue, xAxisLabel: WeekDay.wed.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.terrible.rawValue, xAxisLabel: WeekDay.thu.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.good.rawValue, xAxisLabel: WeekDay.fri.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.usual.rawValue, xAxisLabel: WeekDay.sat.rawValue.capitalized),
            LineChartDataPoint(value: MoodCondition.excellent.rawValue, xAxisLabel: WeekDay.sun.rawValue.capitalized)
        ],
                               pointStyle: PointStyle(fillColour: .green, pointType: .filled, pointShape: .circle),
                               style: LineStyle(lineColour: ColourStyle(colour: .blue), lineType: .line))
        
        let gridStyle = GridStyle(numberOfLines: 4,
                                  lineColour   : Color(.lightGray).opacity(0.5),
                                  lineWidth    : 1,
                                  dash         : [4],
                                  dashPhase    : 0)
        
        let chartStyle = LineChartStyle(infoBoxPlacement    : .infoBox(isStatic: true),
                                        xAxisLabelPosition  : .bottom,
                                        xAxisLabelFont      : .headline,
                                        xAxisLabelColour    : Color.black,
                                        yAxisGridStyle      : gridStyle,
                                        yAxisLabelPosition  : .leading,
                                        yAxisLabelFont      : .headline,
                                        yAxisLabelColour    : Color.black,
                                        yAxisNumberOfLabels : 4,
                                        yAxisLabelType      : .custom
        )
        
        let chartData = LineChartData(dataSets       : data,
                                      metadata       : ChartMetadata(title: "", subtitle: ""),
                                      yAxisLabels    : MoodCondition.statusList,
                                      chartStyle     : chartStyle)
        return chartData
    }
}



struct SwiftUIChartsLibrary_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIChartsLibraryView()
    }
}
