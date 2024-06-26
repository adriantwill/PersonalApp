//
//  GamesView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI


struct GamesView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        NavigationStack {
            ScrollView{
                if (gameVM.nbarankings.children.count == 0){
                    Text("Please Refresh")
                } else {
                    ForEach(gameVM.nbarankings.children[1].standings.entries.sorted(by: {
                        ($0.stats[8].value ?? 0) < ($1.stats[8].value ?? 0)
                    }), id: \.self) { index in
                        NavigationLink(value: index) {
                            HStack {
                                Text("\(index.stats[8].value ?? 0, specifier: "%.0f").")
                                    .padding(.leading, 20)
                                AsyncImage(url: URL(string: index.team.logos[0].href), content: { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }, placeholder: {
                                    ProgressView()
                                })
                                
                                Text(index.team.displayName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                                    .frame(height: 50)
                                    .foregroundStyle(Color(.blue))
                            }
                        }
                        Divider()
                    }
                }
                
            }
            .background(Color("Background"))
            .refreshable {
                await gameVM.getJsonData(api: "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings", whichapi: 0)
            }
            .navigationTitle("NBA")
            .navigationDestination(for: Entry.self) { value in
                SelectGameView(value: value)
            }
            
        }
        
    }
        
}

#Preview {
    GamesView()
        .environmentObject(GameViewModel())
}
