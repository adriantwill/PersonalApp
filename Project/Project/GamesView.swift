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
    @Query(sort: \swiftstandings.win) var items: [swiftstandings]
    @ObservedObject var gamesVM = GameViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(gamesVM.test1.response, id: \.self) { team in
                    NavigationLink(destination: DetailView(nflstand: team)) {
                        Image("\(team.team.name)") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                        Text(team.team.name)
                        Text("\(team.won) - \(team.lost)")
                    }
                    .navigationBarBackButtonHidden()
                }
                .navigationTitle("Current Standings")
            }.navigationBarTitleDisplayMode(.inline)
            
           
            .refreshable {
                gamesVM.getJsonData(api: "https://v1.american-football.api-sports.io//standings?league=1&season=2023", whichapi: 1)
                for (i,item) in items.enumerated(){
                    item.name = gamesVM.test1.response[i].team.name
                    item.win = gamesVM.test1.response[i].won
                    item.loss = gamesVM.test1.response[i].lost
                    item.ties = gamesVM.test1.response[i].ties
                    try? context.save()
                }
            }
        }
        .tint(Color.white)
    }
}


struct DetailView: View {
    @State var nflstand: nflresponse
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 4)
                        .fill(Color(nflstand.team.name)) // Fill the rectangle with the team color
                        .frame(height: 340) // Specify the frame dimensions
                        .ignoresSafeArea()
                    VStack(spacing: 0){
                        Image(nflstand.team.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                        Text(nflstand.team.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .offset(y: -10)
                    }
                }
                Spacer()
            }
        }
    }
    
}
#Preview {
    GamesView()
        .modelContainer(for: swiftstandings.self, inMemory: true)
}
