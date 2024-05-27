//
//  FavoriteGameView.swift
//  Project
//
//  Created by Adrian Will on 5/25/24.
//

import SwiftUI

struct FavoriteGameView: View {
    let value: Team
    @ObservedObject var gameVM = GameViewModel()
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack{
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#\(value.color)"))
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
    FavoriteGameView(value: Team(id: "", uid: "", slug: "", location: "", name: "", abbreviation: "", displayName: "Chicago Bulls", shortDisplayName: "", color: "0e2240", alternateColor: "fec524",  isActive: true, logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")], record: Record(items: [RecordItem(description: "", type: "total", summary: "57-25", stats: [Stat(name: "", value: 0.0), Stat(name: "", value: 0.0), Stat(name: "", value: 109.597565), Stat(name: "", value: 114.85366), Stat(name: "", value: 0.0), Stat(name: "", value: 5.300000000000011), Stat(name: "", value: 114.85366), Stat(name: "", value: 114.85366), Stat(name: "", value: 114.85366), Stat(name: "", value: 114.85366) , Stat(name: "", value: 114.85366), Stat(name: "", value: 114.85366), Stat(name: "", value: 114.85366)])]), nextEvent: [NextEvent(id: "", date: "2024-05-20T00:00Z", name: "", shortName: "", season: Season(year: 0, displayName: ""), seasonType: SeasonType(id: "", type: 0, name: "", abbreviation: ""), timeValid: true, competitions: [Competition(id: "", date: "", attendance: 0, type: CompetitionType(id: "", text: "", abbreviation: "", slug: "", type: ""), timeValid: true, neutralSite: true, boxscoreAvailable: true, ticketsAvailable: true, competitors: [Competitor(id: "", type: "", order: 0, homeAway: "away", team: CompetitorTeam(id: "", location: "Minnesota", abbreviation: "MIA", displayName: "Miami Heat", shortDisplayName: "MIA", logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")]), score: Score(value: 0.0, displayValue: "100"), record: []), Competitor(id: "", type: "", order: 0, homeAway: "away", team: CompetitorTeam(id: "", location: "Minnesota", abbreviation: "CHI", displayName: "Chicago Bulls", shortDisplayName: "Timberwolves", logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")]), score: Score(value: 0.0, displayValue: "110"), record: [])], notes: [], broadcasts: [], tickets: [], status: Status(clock: 0.0, displayClock: "", period: 0, type: StatusType(id: "", name: "STATUS_FINAL", state: "", completed: true, description: "", detail: "", shortDetail: "5/19 - 8:00 PM EDT")))])], standingSummary: ""))
}
