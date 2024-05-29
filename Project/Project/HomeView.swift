//
//  HomeView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @AppStorage("FavTeam") var favTeam: String = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Games Today:")
                        .bold()
                        .font(.title2)
                    if (gameVM.nbacurrentevents.events.count == 0){
                        Text("No Games Today")
                            .padding(20)
                    } else {
                        ScrollView(.horizontal, content: {
                            HStack {
                                ForEach(gameVM.nbacurrentevents.events, id: \.self) { index in
                                    NavigationLink(value: index) {
                                        ZStack{
                                            Rectangle ()
                                                .fill(Color.white)
                                                .frame(width: 170, height: 120)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.black, lineWidth: 0.5)
                                                )
                                                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                                                .padding(10)
                                            VStack(spacing: 0) {
                                                Text("\(index.status.type.shortDetail)")
                                                    .font(.body)
                                                    .padding(.bottom, 10)
                                                ForEach(index.competitions[0].competitors, id: \.self){ comp in
                                                    HStack {
                                                        Image("\(comp.team.displayName)") // Replace with your image name
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 32, height: 32)
                                                        Text("\(comp.team.abbreviation)")
                                                            .padding(.trailing, 10)
                                                        Text("\(comp.score)")
                                                    }
                                                }
                                            }
                                            
                                        }
                                        .foregroundColor(.primary)
                                    }
                                }
                                
                            }
                        })
                        .padding(10)
                        
                    }
                    Text("Favorite Team:")
                        .bold()
                        .font(.title2)
                    if (favTeam == "") {
                        Text("Select Favorite Team Above")
                            .padding(20)
                    } else {
                        NavigationLink(value: gameVM.nbasingleteam.team) {
                            ZStack{
                                Rectangle ()
                                    .fill(Color.white)
                                    .frame(width: 350, height: 140)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10) // Ensures the stroke also has rounded corners
                                            .stroke(Color.black, lineWidth: 0.5) // Black stroke
                                    )
                                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                                    .padding(10)
                                
                                
                                Rectangle()
                                    .fill(Color(hex: "#\(gameVM.nbasingleteam.team.color)"))
                                    .frame(width: 350, height: 40)
                                    .padding(.bottom, 100)
                                    .cornerRadius(10)
                                
                                VStack {
                                    HStack {
                                        Text(gameVM.nbasingleteam.team.displayName)
                                            .foregroundStyle(Color(hex: "#\(gameVM.nbasingleteam.team.alternateColor)"))
                                            .bold()
                                            .font(.title3)
                                        AsyncImage(url: URL(string: gameVM.nbasingleteam.team.logos[0].href), content: { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                    }
                                    .offset(y:-3)
                                    
                                        HStack {
                                            VStack(spacing: 0) {
                                                if (gameVM.nbasingleteam.team.nextEvent[0].competitions[0].status.type.name == "STATUS_FINAL"){
                                                    Text("Last Event:")
                                                        .offset(y:-5)
                                                        .bold()
                                                } else if (gameVM.nbasingleteam.team.nextEvent[0].competitions[0].status.type.name == "STATUS_SCHEDULED"){
                                                    Text("Upcoming Event:")
                                                        .offset(y:-5)
                                                        .bold()
                                                } else {
                                                    Text("Live")
                                                        .offset(y:-5)
                                                        .foregroundColor(.red)
                                                        .bold()
                                                }
                                                Text(gameVM.nbasingleteam.team.nextEvent[0].competitions[0].status.type.shortDetail)
                                                    .padding(.top, 5)
                                                HStack {
                                                    if (gameVM.nbasingleteam.team.nextEvent[0].competitions[0].competitors[0].id == gameVM.nbasingleteam.team.id){
                                                        Text("VS \(gameVM.nbasingleteam.team.nextEvent[0].competitions[0].competitors[1].team.location)")
                                                        AsyncImage(url: URL(string: gameVM.nbasingleteam.team.nextEvent[0].competitions[0].competitors[1].team.logos[0].href), content: { returnedImage in
                                                            returnedImage
                                                                .resizable()
                                                                .frame(width: 32, height: 32)
                                                        }, placeholder: {
                                                            ProgressView()
                                                        })
                                                    } else {
                                                        Text("@ \(gameVM.nbasingleteam.team.nextEvent[0].competitions[0].competitors[0].team.location)")
                                                        AsyncImage(url: URL(string: gameVM.nbasingleteam.team.nextEvent[0].competitions[0].competitors[0].team.logos[0].href), content: { returnedImage in
                                                            returnedImage
                                                                .resizable()
                                                                .frame(width: 32, height: 32)
                                                        }, placeholder: {
                                                            ProgressView()
                                                        })
                                                    }
                                                }
                                            }
                                            Spacer()
                                                .frame(width: 40)
                                            VStack{
                                                Text("Stats:")
                                                    .offset(y:-10)
                                                    .bold()
                                                Text("Overall: \(gameVM.nbasingleteam.team.record.items[0].summary)")
                                                Text("Point Diff: \(gameVM.nbasingleteam.team.record.items[0].stats[5].value, specifier: "%.1f")")
                                            }
                                        }
                                        .padding(.top, 4)
                                    
                                }
                                
                            }
                            .foregroundColor(.primary)
                        }
                        .padding(10)
                    }
                    
                    Text("Standings:")
                        .bold()
                        .font(.title2)
                    Spacer()
                    if (gameVM.nbarankings.children.count == 0){
                    } else {
                    ZStack{
                        Rectangle ()
                            .fill(Color.white)
                            .frame(width: 350, height: 190)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10) // Ensures the stroke also has rounded corners
                                    .stroke(Color.black, lineWidth: 0.5) // Black stroke
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                            .padding(10)
                        
                        ScrollView(.vertical) {
                            HStack {
                                ForEach(gameVM.nbarankings.children.reversed(), id: \.self) { conference in
                                    VStack {
                                        Text(conference.abbreviation)
                                            .font(.title3)
                                            .frame(maxWidth: 200)
                                            .fontWeight(.semibold)
                                        ForEach(conference.standings.entries.sorted(by: {
                                          ($0.stats[8].value ?? 0) < ($1.stats[8].value ?? 0)
                                        }), id: \.self) { index in
                                            HStack {
                                                AsyncImage(url: URL(string: index.team.logos[0].href), content: { returnedImage in                             returnedImage
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                        .padding(.leading, 18)
                                                }, placeholder: {
                                                    ProgressView()
                                                })
                                                Text("\(index.stats[8].value ?? 0, specifier: "%.0f").")
                                                Text(index.team.name)
                                                    .frame(maxWidth: 190, alignment: .leading)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: 340, height: 170)
                        
                    }
                }
                    Spacer()
                }
                    
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu {
                            ForEach(gameVM.nbateam, id: \.self) { option in
                                Button(action: {
                                    favTeam = option.code
                                }) {
                                    Text(option.name)
                                }
                            }
                        }
                        label: {
                                Image(systemName: "basketball")
                                    
                        }
                    }
                }
               
            }
            .refreshable {
                
                await gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard", whichapi: 4)
                if (favTeam != "") {
                    await gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/\(favTeam)", whichapi: 3)
                }
                await gameVM.getJsonData(api: "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings", whichapi: 0)
                
            }
            .task {
               // if gameVM.hasExceededLimit(){
                    if (favTeam != "") {
                        await gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/\(favTeam)", whichapi: 3)
                    }
                await gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard", whichapi: 4)
                await gameVM.getJsonData(api: "https://site.web.api.espn.com/apis/v2/sports/basketball/nba/standings", whichapi: 0)
             //   }
            }
        //    .background(Color("Background"))
            .navigationTitle("NBA")
            .navigationDestination(for: Team.self) { value in
                FavoriteGameView(value: value)
            }
            .navigationDestination(for: EventEvent.self) { value in
                CurrentGameView(value: value)
            }
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(GameViewModel())
}
