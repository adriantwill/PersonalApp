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
                    Text("Current Live Games:")
                        .multilineTextAlignment(.leading)
                        .bold()
                    ScrollView(.horizontal, content: {
                        HStack {
                            ForEach(gameVM.test.response, id: \.self) { index in
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
                                        Text("\(index.status.clock ?? "0")")
                                            .font(.body)
                                            .foregroundColor(.red)
                                            
                                            .padding(.leading, 40)
                                            .padding(.bottom, 10)
                                        HStack {
                                            Image("\(index.teams.visitors.name)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.teams.visitors.code)")
                                                .padding(.trailing, 20)
                                            Text("\(index.scores.visitors.points ?? 0)")
                                        }

                                        HStack {
                                            Image("\(index.teams.home.name)") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("\(index.teams.home.code)")
                                                .padding(.trailing, 20)
                                                .fixedSize()
                                            
                                            Text("\(index.scores.home.points ?? 0)")
                                                .fixedSize()
                                        }
                                    }
                                    
                                }
                            }
                        }
                    })
                    Spacer()
                        .frame(height: 40)
                    Text("Favorite Team:")
                        .multilineTextAlignment(.leading)
                        .bold()
                    Spacer()
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
                                .padding(.top, -20)
                                .padding()
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
                    Spacer()
                        .frame(height: 40)
                    Text("Draft:")
                        .bold()
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
                                
                                VStack {

                                    Text("      Team                                         SOS")
                                        .foregroundColor(.black)
                                        .frame(width: 320)
                                        .bold()
                                    Spacer()
                                        .frame(height: 13)
                                        ForEach(gameVM.draftteams.prefix(4), id: \.self) { index in
                                            HStack {
                                                Image(index.name) // Replace with your image name
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 32, height: 32)
                                                Text(index.name)
                                                    .frame(maxWidth: 190, alignment: .leading)
                                                Text(index.winloss)
                                                                                          
                                            }
                                            
                                            Spacer()
                                                .frame(height: 1)
                                        
                                    }
                                
                                }
                                
                        }
                        
                    }
                    
                    Spacer()
                }
                
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu {
                            ForEach(gameVM.nbateam.teams, id: \.self) { option in
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
                gameVM.getJsonData(api: "https://v2.nba.api-sports.io/games?date=\(gameVM.getDate())", whichapi: 0)
            }
        }
    }
}

#Preview {
    HomeView()
}
