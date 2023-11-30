//
//  ContentView.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI

struct LineView: View {
    var dataPoints: [Double?]
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            Path { path in
                path.move(to: CGPoint(x: 0, y: height * self.ratio(for: 0)))
                for index in 0..<dataPoints.count {
                    path.addLine(to: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * self.ratio(for: index)))
                }
            }
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineJoin: .round))
        }
        .padding()
    }
    private func ratio(for index: Int) -> Double {
        let pointValue = (dataPoints[index] ?? 0.0) 
        return 1 - (pointValue / 3)
    }
}

struct LineChartCircleView: View {
    var dataPoints: [Double?]
    var radius: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: (height * self.ratio(for: 0)) - radius))
                path.addArc(center: CGPoint(x: 0, y: height * self.ratio(for: 0)),
                            radius: radius, startAngle: .zero,
                            endAngle: .degrees(360.0), clockwise: false)
                for index in 1..<dataPoints.count {
                    path.move(to: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * (dataPoints[index] ?? 0) / 3))
                    
                    path.addArc(center: CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * self.ratio(for: index)),
                                radius: radius, startAngle: .zero,
                                endAngle: .degrees(360.0), clockwise: false)
                }
            }
            .foregroundColor(.green)
        }
        .padding()
    }
    private func ratio(for index: Int) -> Double {
        return 1 - ((dataPoints[index] ?? 0) / 3)
    }
}

struct LinesForYlabel: View {
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            Path { path in
                let yStepWidth = height / 3
                (0...3).forEach { index in
                    let y = CGFloat(index) * yStepWidth
                    path.move(to: .init(x: 0, y: y))
                    path.addLine(to: .init(x: width, y: y))
                }
            }
            .stroke(style: StrokeStyle( lineWidth: 1, dash: [4]))
            .foregroundColor(Color.gray)
        }
        .padding(.vertical)
    }
}

struct YaxisView: View {
    var scaleFactor: Double
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            ForEach(MoodCondition.allCases, id:  \.rawValue) { condition in
                HStack {
                    Spacer()
                    Text(condition.name.capitalized)
                        .font(Font.headline)
                        .lineLimit(1)
//                        .minimumScaleFactor(0.2)
                }
                .offset(y: (height * 0.9) - (CGFloat(MoodCondition.allCases.firstIndex(of: condition) ?? 0) * CGFloat(scaleFactor)))
            }
        }
    }
}

enum MoodCondition: Double, CaseIterable {
    case terrible = 0
    case usual
    case good
    case excellent
    
    var name: String {
        switch self {
        case .terrible:
            return "Terrible"
        case .usual:
            return "Usual"
        case .good:
            return "Good"
        case .excellent:
            return "Excellent"
        }
    }
    
    static var statusList: [String] {
        return MoodCondition.allCases.map { $0.name }
    }
}

struct XaxisView: View {
    var body: some View {
        GeometryReader { geometry in
            let labelWidth = (geometry.size.width * 0.8) / CGFloat(WeekDay.allCases.count + 1)
            HStack {
                Rectangle()
                    .frame(width: geometry.size.width * 0.15)
                ForEach(WeekDay.allCases, id: \.rawValue) { item in
                    Text(item.rawValue.capitalized)
                        .font(Font.headline)
                        .frame(width: labelWidth)
                }
            }
        }
    }
}

enum WeekDay: String, CaseIterable {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    
}

struct LineChartView: View {
    var dataPoints: [Double?]
    var body: some View {
        GeometryReader { geometry in
            let axisWidth = geometry.size.width * 0.23
            let fullChartHeight = geometry.size.height
            let scaleFactor = (fullChartHeight * 1.15) / CGFloat(MoodCondition.allCases.count)
            VStack {
                HStack {
                    YaxisView(scaleFactor: Double(scaleFactor))
                        .frame(width: axisWidth, height: fullChartHeight)
                    ZStack {
                        if !dataPoints.dropFirst().allSatisfy({ $0 == nil }) {
                            LinesForYlabel()
                            LineView(dataPoints: dataPoints)
                            
                            LineChartCircleView(dataPoints: dataPoints, radius: 4.0)
                            
                        }
                    }
                    .frame(height: fullChartHeight)
                }
                XaxisView()
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}


let selectedWeek: [Double?] = [ MoodCondition.excellent.rawValue, MoodCondition.terrible.rawValue, MoodCondition.good.rawValue, MoodCondition.terrible.rawValue, MoodCondition.good.rawValue, MoodCondition.usual.rawValue, MoodCondition.excellent.rawValue ]


struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("A line graph through the Path")
                    .font(Font.headline)
                    .foregroundColor(.blue)
                LineChartView(dataPoints: selectedWeek)
                Spacer()
                Text("A line graph through the SwiftUIChartsLibrary")
                    .font(Font.headline)
                    .foregroundColor(.blue)
                SwiftUIChartsLibraryView()
                Spacer()
                Text("A line graph through the Charts")
                    .font(Font.headline)
                    .foregroundColor(.blue)
                ChartsView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
