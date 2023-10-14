//
//  ContentView.swift
//  CircularTabView
//
//  Created by Satoru Nishimura on 2023/10/14.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            pageView(number: 1, color: .blue)
            pageView(number: 2, color: .green)
            pageView(number: 3, color: .yellow)
            pageView(number: 4, color: .purple)
            pageView(number: 5, color: .red)
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: selection) { oldValue, newValue in
            print("old:\(oldValue),new: \(newValue)")
        }
        
    }
    
    func pageView(number: Int, color: Color) -> some View {
        ZStack {
            color.ignoresSafeArea()
            Text("Page \(number)")
        }
        .tag(number-1)
    }
}

#Preview {
    ContentView()
}
