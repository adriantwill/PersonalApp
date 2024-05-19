//
//  HomeView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var gameVM = GameViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 30)
                    Text("Games Today:")
                        .bold()
                        .font(.title2)
                    if (gameVM.test4.events.count == 0){
                        Text("No Games Today")
                            .padding(.top, 20)
                    } else {
                    ScrollView(.horizontal, content: {
                        HStack {
                            ForEach(gameVM.test4.events, id: \.self) { index in
                                ZStack{
                                    Rectangle ()
                                        .fill(Color.white)
                                        .frame(width: 150, height: 120)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 0.5)
                                        )
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 4)
                                        .padding(10)
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("\(index.status.type.shortDetail)")
                                            .font(.body)
                                            .padding(.leading, 20)
                                            .padding(.bottom, 10)
                                        HStack {
                                            Image("\(index.competitions[0].competitors[0].team.displayName)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.competitions[0].competitors[0].team.abbreviation)")
                                                .padding(.trailing, 20)
                                            Text("\(index.competitions[0].competitors[0].score)")
                                        }
                                        
                                        HStack {
                                            Image("\(index.competitions[0].competitors[1].team.displayName)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.competitions[0].competitors[1].team.abbreviation)")
                                                .padding(.trailing, 20)
                                                .fixedSize()
                                            
                                            Text("\(index.competitions[0].competitors[1].score)")
                                                .fixedSize()
                                        }
                                    }
                                    
                                }
                                }
                                
                            }
                        })
                    }
                    
                    Spacer()
                        .frame(height: 40)
                    Text("Favorite Team:")
                        .bold()
                        .font(.title2)
                    Spacer()
                    if (gameVM.favnbateam.id == -1) {
                        Text("Select Favorite Team Above")
                            .padding(.top, 20)
                    } else {
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
                           
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(gameVM.convertUTCtoPacificTime(utcDate: gameVM.test3.team.nextEvent[0].date, long: gameVM.test3.team.nextEvent[0].competitions[0].status.type.name))")
                                    .font(.body)
                                    .padding(.bottom, 20)
                                    .padding(.leading, 40)
                                  
                                HStack {
                                    Image(gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].team.displayName) // Replace with your image name
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 32, height: 32)
                                    Text(gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].team.abbreviation)
                                        .padding(.trailing, 40)
                                       
                                    Text(gameVM.test3.team.nextEvent[0].competitions[0].competitors[0].score?.displayValue ?? "Live")
                                        .padding(.trailing, 40)
                                        
                                }
                                
                                HStack {
                                    Image(gameVM.test3.team.nextEvent[0].competitions[0].competitors[1].team.displayName) // Replace with your image name
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 32, height: 32)
                                    Text(gameVM.test3.team.nextEvent[0].competitions[0].competitors[1].team.abbreviation)
                                        .padding(.trailing, 40)
                                        
                                    Text(gameVM.test3.team.nextEvent[0].competitions[0].competitors[1].score?.displayValue ?? "Live")
                                        .padding(.trailing, 40)
                                        
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
                                    self.gameVM.favnbateam = option
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
}
