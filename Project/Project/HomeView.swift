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
    @Query(sort: \swiftscores.hscore) var swifttest: [swiftscores]
    var body: some View {
        NavigationStack {
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
                                        Text("d")
                                            .font(.body)
                                            
                                            .padding(.top, -20)
                                            .padding()
                                        HStack {
                                            Image("d") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("d")
                                                .padding(.trailing, 20)
                                            Text("d")
                                        }

                                        HStack {
                                            Image("d") // Replace with your image name
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 32, height: 32)
                                            Text("d")
                                                .padding(.trailing, 20)
                                                .fixedSize()
                                            Text("\(index.scores.visitors.score)")
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
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(gameVM.nbateam.teams, id: \.self) { option in
                            Button(action: {
                                self.gameVM.favnflteam = option.name
                            }) {
                                Text(option.name)
                            }
                        }
                    } label: {
                        Image(systemName: "basketball")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(gameVM.nflteams, id: \.self) { option in
                            Button(action: {
                                self.gameVM.favnbateam = option
                            }) {
                                Text(option)
                            }
                        }
                    } label: {
                        Image(systemName: "football")
                    }
                }
            }
            .refreshable {
                gameVM.getJsonData(api: "https://v2.nba.api-sports.io/games?date=\(gameVM.getDate())", whichapi: 0)
                let swifttest = gameVM.test.response.map{ swiftscores(from: $0)}
                swifttest.forEach{context.insert($0)}
               // gameVM.getJsonData(api: "https://v2.nba.api-sports.io/games?season=2023&team=\(gameVM.nbateam.find(identifier: gameVM.favnbateam, entered: "Name", returned: "Id") ) ", whichapi: 0)
          }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [swiftscores.self, swiftnflresponse.self, swiftnfldraft.self])
}
