//
//  Graph+Shapes.swift
//  TestGraphProject
//
//  Created by Oleh on 01.12.2023.
//

import SwiftUI

struct LineView: View {
    let dataPoints: [Double?]
    
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
        return 1 - ((dataPoints[index] ?? 0) / 3)
    }
}

struct LineChartCircleView: View {
    let dataPoints: [Double?]
    let radius: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: (height * self.ratio(for: 0)) - radius))
                path.addArc(center: CGPoint(x: 0, y: height * self.ratio(for: 0)),
                            radius: radius,
                            startAngle: .zero,
                            endAngle: .degrees(360.0),
                            clockwise: false)
                
                for index in 1..<dataPoints.count {
                    let point = CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * (dataPoints[index] ?? 0) / 3
                    )
                    path.move(to: point)
                    
                    let center = CGPoint(
                        x: CGFloat(index) * width / CGFloat(dataPoints.count - 1),
                        y: height * self.ratio(for: index)
                    )
                    path.addArc(center: center,
                                radius: radius,
                                startAngle: .zero,
                                endAngle: .degrees(360.0),
                                clockwise: false)
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

struct LinesForYLabel: View {
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                let yStepWidth = height / 3
                
                for index in 0...3 {
                    let y = CGFloat(index) * yStepWidth
                    path.move(to: .init(x: 0, y: y))
                    path.addLine(to: .init(x: width, y: y))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
            .foregroundColor(Color.gray)
        }
        .padding(.vertical)
    }
}

struct YAxisView: View {
    var scaleFactor: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            ForEach(MoodCondition.allCases, id: \.rawValue) { condition in
                let index = MoodCondition.allCases.firstIndex(of: condition) ?? 0
                
                HStack {
                    Spacer()
                    Text(condition.name.capitalized)
                        .font(Font.headline)
                        .lineLimit(1)
                }
                .offset(y: (height * 0.9) - (CGFloat(index) * scaleFactor))
            }
        }
    }
}

struct XAxisView: View {
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

struct LineChartView: View {
    let dataPoints: [Double?]
    
    init() {
        dataPoints = [
            MoodCondition.excellent.rawValue,
            MoodCondition.terrible.rawValue,
            MoodCondition.good.rawValue,
            MoodCondition.terrible.rawValue,
            MoodCondition.good.rawValue,
            MoodCondition.usual.rawValue,
            MoodCondition.excellent.rawValue
        ]
    }
    
    var body: some View {
        GeometryReader { geometry in
            let axisWidth = geometry.size.width * 0.23
            let fullChartHeight = geometry.size.height
            let scaleFactor = (fullChartHeight * 1.15) / CGFloat(MoodCondition.allCases.count)
            
            VStack {
                HStack {
                    YAxisView(scaleFactor: Double(scaleFactor))
                        .frame(width: axisWidth, height: fullChartHeight)
                    ZStack {
                        LinesForYLabel()
                        LineView(dataPoints: dataPoints)
                        LineChartCircleView(dataPoints: dataPoints, radius: 4.0)
                    }
                    .frame(height: fullChartHeight)
                }
                XAxisView()
            }
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}

#Preview {
    LineChartView()
}

