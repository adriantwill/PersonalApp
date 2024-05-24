//
//  CurrentGameView.swift
//  Project
//
//  Created by Adrian Will on 5/24/24.
//

import SwiftUI

struct CurrentGameView: View {
    let value: EventEvent
    var body: some View {
        Text("Hello, World!")
            .font(.title)
    }
}

#Preview {
    CurrentGameView(value: EventEvent(id: "", uid: "", date: "", name: "", shortName: "", season: EventSeasonEvent(year: 0, type: 0, slug: ""), competitions: [], status: StatusEvent(clock: 0, displayClock: "", period: 0, type: StatusTypeEvent(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: ""))))
}
