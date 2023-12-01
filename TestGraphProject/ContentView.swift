//
//  ContentView.swift
//  TestGraphProject
//
//  Created by Oleh on 27.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                titleView(title: "A line graph through the Path")
                LineChartView()
                Spacer()
                
                titleView(title: "A line graph through the SwiftUIChartsLibrary")
                SwiftUIChartsLibraryView()
                Spacer()
                
                titleView(title: "A line graph through the Charts")
                ChartsView()
            }
        }
    }
    
    private func titleView(title: String) -> some View {
        Text(title)
            .font(Font.headline)
            .foregroundColor(.blue)
    }
}

#Preview {
    ContentView()
}

