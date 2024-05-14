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
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 30)
                Text("Upcoming Games:")
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
                                    Text("\(gameVM.convertUTCtoPacificTime(utcDate: index.date.start, long: index.status.long))")
                                        .font(.body)
                                        .foregroundColor(.red)
                                        
                                        .padding(.top, -20)
                                        .padding()
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
                        Text(gameVM.favgames.time)
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.top, -20)
                            .padding()
                        HStack {
                            Image(gameVM.favgames.awayfull) // Replace with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            Text(gameVM.favgames.away)
                                .padding(.trailing, 40)
                            Text(gameVM.favgames.ascore)
                                .padding(.trailing, 40)
                            Text(gameVM.favgames.arecord)
                        }

                        HStack {
                            Image(gameVM.favgames.homefull) // Replace with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                            Text(gameVM.favgames.home)
                                .padding(.trailing, 40)
                            Text(gameVM.favgames.hscore)
                                .padding(.trailing, 40)
                            Text(gameVM.favgames.hrecord)
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
        }
        .refreshable {
            gameVM.getJsonData(api: "https://v2.nba.api-sports.io/games?date=2024-04-30", whichapi: 0)
            gameVM.getJsonData(api: "https://v2.nba.api-sports.io/games?date=\(gameVM.getDate())", whichapi: 0)
            
        }
    }
}

#Preview {
    HomeView()
}
