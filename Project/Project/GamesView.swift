//
//  GamesView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI
import SwiftData

struct GamesView: View {
    @Environment(\.modelContext) var context
    @ObservedObject var gameVM = GameViewModel()
    @Query(sort: \swiftnflresponse.won) var swifttest: [swiftnflresponse]
    var body: some View {
        NavigationStack {
            if (gameVM.test0.children.count == 0){
                Text("Please Refresh")
            } else {
                List {
                    ForEach(gameVM.test0.children[1].standings.entries.sorted(by: {
                        ($0.stats[8].value ?? 0) < ($1.stats[8].value ?? 0)
                    }), id: \.self) { index in
                        HStack {
                            AsyncImage(url: URL(string: index.team.logos[0].href), content: { returnedImage in                             returnedImage
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            }, placeholder: {
                                ProgressView()
                            })
                            Text("\(index.stats[8].value ?? 0, specifier: "%.0f").")
                            Text(index.team.abbreviation)
                            //   .frame(maxWidth: 190, alignment: .leading)
                        }
                    }
                    .navigationTitle("Current Standings")
                }.navigationBarTitleDisplayMode(.inline)
               
            }
                
        }
        .tint(Color.white)
        .onAppear {
           // gameVM.getJsonData(api: "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings", whichapi: 0)
        }
    }
}

#Preview {
    GamesView()
        .modelContainer(for: [swiftnflresponse.self, swiftnfldraft.self])
}
