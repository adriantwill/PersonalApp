//
//  SelectGameView.swift
//  Project
//
//  Created by Adrian Will on 5/25/24.
//

import SwiftUI

struct SelectGameView: View {
    let value: Entry
    @ObservedObject var gameVM = GameViewModel()
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack{
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#\(value.)"))
                            .frame(height: 300) // Specify the frame dimensions
                            .shadow(radius: 10)
                        VStack(spacing: 0) {
                            
                            AsyncImage(url: URL(string: value.logos[0].href), content: { returnedImage in
                                returnedImage
                                    .resizable()
                                    .frame(width: 150, height: 150)
                            }, placeholder: {
                                ProgressView()
                            })
                            Text("\(value.displayName)")
                                .frame(maxWidth: .infinity, alignment: .center) // Take up the entire width
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .padding(.bottom, 15)
                                .foregroundStyle(Color(hex: "#\(value.alternateColor)"))
                            
                        }
                    }
                    if (value.nextEvent[0].competitions[0].status.type.name == "STATUS_FINAL"){
                        
                        Text("Last Event, \(gameVM.convertUTCtoPacificTime(utcDate: value.nextEvent[0].date))")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                        
                    } else if (value.nextEvent[0].competitions[0].status.type.name == "STATUS_SCHEDULED"){
                        
                        Text("Upcoming Event, \(gameVM.convertUTCtoPacificTime(utcDate: value.nextEvent[0].date))")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                    } else {
                        Text("Live")
                            .foregroundColor(.red)
                    }
                    HStack {
                        AsyncImage(url: URL(string: value.nextEvent[0].competitions[0].competitors[1].team.logos[0].href), content: { returnedImage in
                            returnedImage
                                .resizable()
                                .frame(width: 30, height: 30)
                        }, placeholder: {
                            ProgressView()
                        })
                        Text("\(value.nextEvent[0].competitions[0].competitors[1].team.shortDisplayName) @ \(value.nextEvent[0].competitions[0].competitors[0].team.shortDisplayName)")
                            .font(.system(size: 22))
                        AsyncImage(url: URL(string: value.nextEvent[0].competitions[0].competitors[0].team.logos[0].href), content: { returnedImage in
                            returnedImage
                                .resizable()
                                .frame(width: 30, height: 30)
                        }, placeholder: {
                            ProgressView()
                        })
                    }
                    if (value.nextEvent[0].competitions[0].competitors[1].score != nil) {
                        Text("\(value.nextEvent[0].competitions[0].competitors[1].score?.displayValue ?? "") - \(value.nextEvent[0].competitions[0].competitors[0].score?.displayValue ?? "")")
                            .font(.system(size: 28))
                            .padding(.top, -8)
                    }
                    Text("Standings")
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 30){
                        VStack {
                            Text("Seed:")
                                .bold()
                                .padding(.bottom, 1)
                            Text("\(value.record.items[0].stats[11].value, specifier: "%.0f")")
                        }
                        VStack {
                            Text("GB:")
                                .bold()
                                .padding(.bottom, 1)
                            Text("\(value.record.items[0].stats[7].value, specifier: "%.0f")")
                        }
                        ForEach(value.record.items, id: \.self) { index in
                            VStack {
                                Text("\(index.type.capitalized):")
                                    .bold()
                                    .padding(.bottom, 1)
                                Text("\(index.summary)")
                            }
                        }

                    }
                    Text("Stats")
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                        .font(.title2)
                        .fontWeight(.medium)
                  
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    FavoriteGameView(value: Entry(team: TeamRankings(id: "", uid: "", location: "", name: "", abbreviation: "", displayName: "", shortDisplayName: "", isActive: true, logos: [], links: []), stats: []))
}
