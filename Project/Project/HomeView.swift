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
    @Query(sort: \gamesdata.hname) var games: [gamesdata]
    @Environment(\.modelContext) var context
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 30)
                Text("Upcoming Games:")
                    .multilineTextAlignment(.leading)
                    .bold()
                    .onAppear {
                        gameVM.addummy()
                    }
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
                                    Text("LIVE")
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
                                        Text("\(index.scores.visitors.points)")
                                  
                                    }

                                    HStack {
                                        Image("\(index.teams.home.name)") // Replace with your image name
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 32, height: 32)
                                        Text("\(index.teams.home.code)")
                                            .padding(.trailing, 20)
                                            .fixedSize()
                                        Text("\(index.scores.home.points)")
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
                    .frame(height: -10)
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
                    .frame(height: -10)
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
            gameVM.getJsonData()
            for index in gameVM.test.response{
                print(index.teams.visitors.name)
                let test = gamesdata(hname: index.teams.home.name, aname: index.teams.visitors.name, hcode: index.teams.home.code, acode: index.teams.visitors.code, hscore: index.scores.home.points, ascore: index.scores.visitors.points)
                print(test.acode)
                context.insert(test)
                print(context)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: gamesdata.self, inMemory: true)
}
