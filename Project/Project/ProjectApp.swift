//
//  ProjectApp.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI
import SwiftData

@main
struct ProjectApp: App {
    @StateObject var gameVM = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [swiftnfldraft.self])
                .environmentObject(gameVM)
        }
    }
}
