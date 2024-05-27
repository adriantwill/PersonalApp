//
//  ContentView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            AreaView()
                .tabItem {
                    Image(systemName: "map.fill")
                }
            GamesView()
                .tabItem{
                    Image(systemName: "person.3.fill")
                }
            DraftView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameViewModel())
}
