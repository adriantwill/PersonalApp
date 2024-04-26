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
    @ObservedObject var gamesVM = GameViewModel()
    @Query(sort: \swiftnflresponse.won) var swifttest: [swiftnflresponse]
    var body: some View {
        NavigationStack {
            List {
                ForEach(swifttest, id: \.self) { team in
                    NavigationLink(destination: DetailView(nflstand: team)) {
                        Image("\(team.team)") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                        Text(team.team)
                        Text("\(team.won) - \(team.lost)")
                    }
                    .navigationBarBackButtonHidden()
                }
                .onDelete { indexSet in
                    for index in indexSet{
                        context.delete(swifttest[index])
                    }
                }
                .navigationTitle("Current Standings")
            }.navigationBarTitleDisplayMode(.inline)
            
           
            .refreshable {
                gamesVM.getJsonData(api: "https://v1.american-football.api-sports.io//standings?league=1&season=2023", whichapi: 1)
                let swifttest = gamesVM.test1.response.map{ swiftnflresponse(from: $0)}
                swifttest.forEach{context.insert($0)}
            }
        }
        .tint(Color.white)
    }
}


struct DetailView: View {
    @State var nflstand: swiftnflresponse
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack{
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                            .fill(Color(nflstand.team)) // Fill the rectangle with the team color
                            .frame(height: 320) // Specify the frame dimensions
                        VStack(spacing: 0){
                            Image(nflstand.team)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .shadow(radius: 10)
                            Text(nflstand.team)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                                .offset(y: -10)
                        }
                    }
                    Spacer(minLength: 35)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Division: \(nflstand.division)")
                            .font(.title2)
                        Text("Record: \(nflstand.won) - \(nflstand.lost) - \(nflstand.ties)")
                            .font(.title2)
                        Text("Final Standing: \(nflstand.position)")
                            .font(.title2)
                    }
                    .padding(.leading, -150)
                    
                   
                }
            }
            .ignoresSafeArea()
        }
    }
    
}
#Preview {
    GamesView()
        .modelContainer(for: [swiftnflresponse.self])
}
