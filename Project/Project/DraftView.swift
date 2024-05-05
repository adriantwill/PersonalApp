//
//  DraftView.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import SwiftUI

struct DraftView: View {
    @ObservedObject var gameVM = GameViewModel()
    var body: some View {
        List{
            ScrollView{
                ForEach(gameVM.test2.prefix(32), id: \.self) { index in
                    HStack {
                        Text("\(index.overall). ")
                        Image("\(index.nflTeam)NFL")
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text(index.name)
                            Text("\(index.position), \(index.collegeTeam)")
                                .font(.system(size: 15))
                        }
                        Spacer()
                        Image("\(index.name)")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    }

                  
                
                }
            }
        }
        .refreshable {
            gameVM.getJsonData(api: "https://api.collegefootballdata.com/draft/picks?year=2024", whichapi: 2)
        }
    }
}

#Preview {
    DraftView()
}
