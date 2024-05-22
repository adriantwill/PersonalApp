//
//  HomeView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @ObservedObject var gameVM = GameViewModel()
    @Environment(\.modelContext) var context
    @Query var SwiftDataFavNBA: [SwiftDataNBATeam]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Games Today:")
                        .bold()
                        .font(.title2)
                    if (gameVM.test4.events.count == 0){
                        Text("No Games Today")
                            .padding(20)
                    } else {
                    ScrollView(.horizontal, content: {
                        HStack {
                            ForEach(gameVM.test4.events, id: \.self) { index in
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
                                        HStack {
                                            Image("\(index.competitions[0].competitors[0].team.displayName)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.competitions[0].competitors[0].team.abbreviation)")
                                                .padding(.trailing, 10)
                                            Text("\(index.competitions[0].competitors[0].score)")
                                        }
                                        HStack {
                                            Image("\(index.competitions[0].competitors[1].team.displayName)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.competitions[0].competitors[1].team.abbreviation)")
                                                .padding(.trailing, 10)
                                            Text("\(index.competitions[0].competitors[1].score)")
                                        }
                                    }
                                    
                                }
                                }
                                
                            }
                        })
                    .padding(10)
                        
                    }
                    Text("Favorite Team:")
                        .bold()
                        .font(.title2)
                        .padding(.bottom, 15)
                        ZStack{
                            Rectangle ()
                                .fill(Color.white)
                                .frame(width: 350, height: 130)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Ensures the stroke also has rounded corners
                                        .stroke(Color.black, lineWidth: 0.5) // Black stroke
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                                .padding(10)
                       
                            if (SwiftDataFavNBA.count == 0) {
                                Text("Select Favorite Team Above")
                            } else {
            
                                Rectangle()
                                .fill(Color(hex: "#\(gameVM.test3.team.color)"))
                                    .frame(width: 350, height: 40)
                                    .padding(.bottom, 120)
                                    .cornerRadius(10)
                                        
                                    
                                VStack {
                                    HStack {
                                        Text(gameVM.test3.team.displayName)
                                            .foregroundStyle(Color(hex: "#\(gameVM.test3.team.alternateColor)"))
                                            .bold()
                                            .font(.title3)
                                            
                                        AsyncImage(url: URL(string: gameVM.test3.team.logos[0].href), content: { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                               
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                    }
                                    .offset(y:-18)
                                    VStack {
                                        HStack {
                                            VStack(spacing: 0) {
                                                if (gameVM.test3.team.nextEvent[0].competitions[0].status.type.name == "STATUS_FINAL"){
                                                    Text("Last Event:")
                                                        .offset(y:-5)
                                                } else{
                                                    Text("Upcoming Event:")
                                                        .offset(y:-5)
                                                }
                                                Text(gameVM.test3.team.nextEvent[0].competitions[0].status.type.shortDetail)
                                                    .padding(.top, 5)
                                                
                                                HStack {
                                                    if (gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].id == gameVM.test3.team.id){
                                                        Text("VS \(gameVM.test3.team.nextEvent[0].competitions[0].competitors[1].team.location)")
                                                        AsyncImage(url: URL(string: gameVM.test3.team.nextEvent[0].competitions[0].competitors[1].team.logos[0].href), content: { returnedImage in
                                                            returnedImage
                                                                .resizable()
                                                                .frame(width: 32, height: 32)
                                                        }, placeholder: {
                                                            ProgressView()
                                                        })
                                                    } else {
                                                        Text("@ \(gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].team.location)")
                                                        AsyncImage(url: URL(string: gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].team.logos[0].href), content: { returnedImage in
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
                                                Text("Overall: \(gameVM.test3.team.record.items[0].summary)")
                                                Text("Point Diff: \(gameVM.test3.team.record.items[0].stats[5].value, specifier: "%.1f")")
                                            }
                                        }
                                    }
                            
                                }
                        }
                    }
                    Spacer()
                        .frame(height: 40)
                    Text("Standings:")
                        .bold()
                        .font(.title2)
                    Spacer()
                    VStack{
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
                                    VStack {
                                        Text("West")
                                            .font(.title3)
                                            .frame(maxWidth: 200)
                                        ForEach(gameVM.test0.response.prefix(15).sorted(by: { $0.conference.rank < $1.conference.rank }), id: \.self) { index in
                                            HStack {
                                                Image(index.team.name) // Replace with your image name
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 32, height: 32)
                                                Text("\(index.conference.rank).")
                                                Text(index.team.nickname)
                                                    .frame(maxWidth: 190, alignment: .leading)
                                            }
                                        }
                                    }
                                    
                                    VStack {
                                        Text("East")
                                            .font(.title3)
                                            .frame(maxWidth: 200)
                                        ForEach(gameVM.test0.response.suffix(15).sorted(by: { $0.conference.rank < $1.conference.rank }), id: \.self) { index in
                                            HStack {
                                                Image(index.team.name) // Replace with your image name
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 32, height: 32)
                                                Text("\(index.conference.rank).")
                                                Text(index.team.nickname)
                                                    .frame(maxWidth: 190, alignment: .leading)
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
                                    context.insert(SwiftDataNBATeam(iden: 1, codename: option.code))
                                    gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/\(option.code)", whichapi: 3)
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
                gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard", whichapi: 4)
                gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/\(SwiftDataFavNBA.last?.codename ?? "")", whichapi: 3)
                gameVM.getJsonData(api: "https://v2.nba.api-sports.io/standings?league=standard&season=2023", whichapi: 0)
            }
            .onAppear {
                //gameVM.getJsonData(api: "https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard", whichapi: 4)
            }

        }
        
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [swiftnflresponse.self, swiftnfldraft.self, SwiftDataNBATeam.self])
}
