//
//  CurrentGameView.swift
//  Project
//
//  Created by Adrian Will on 5/24/24.
//

import SwiftUI

struct CurrentGameView: View {
    let value: EventEvent
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack{
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                    LinearGradient(
                                            gradient: Gradient(colors: [Color(hex: "#\(value.competitions[0].competitors[1].team.color)"), Color(hex: "#\(value.competitions[0].competitors[0].team.color)")]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            .frame(height: 300) // Specify the frame dimensions
                            .shadow(radius: 10)
                        VStack(spacing: 0) {
                            HStack {
                                AsyncImage(url: URL(string: value.competitions[0].competitors[1].team.logo), content: { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                }, placeholder: {
                                    ProgressView()
                                })
                                Spacer()
                                    .frame(width: 40)
                                AsyncImage(url: URL(string: value.competitions[0].competitors[0].team.logo), content: { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                }, placeholder: {
                                    ProgressView()
                            })
                            }
                            Text("\(value.competitions[0].competitors[1].team.name) at \(value.competitions[0].competitors[0].team.name)")
                                .frame(maxWidth: .infinity, alignment: .center) // Take up the entire width
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .padding(.bottom, 15)
                                .foregroundColor(.white)
                        }
                    }
                    Text("\(value.competitions[0].competitors[1].score) - \(value.competitions[0].competitors[0].score)")
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .shadow(radius: 2)
                    Text(value.competitions[0].status.type.shortDetail)
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("\(value.competitions[0].competitors[0].team.name) Leaders:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .padding(.top, 15)
                        
                        .font(.title3)
                    ScrollView(.horizontal, content: {
                        HStack(spacing: 30){
                            ForEach(value.competitions[0].competitors[0].leaders, id: \.self) { index in
                                VStack {
                                    Text("\(index.displayName):")
                                        .bold()
                                    HStack {
                                        AsyncImage(url: URL(string: index.leaders[0].athlete.headshot), content: { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .scaledToFill()
                                                .frame(width: 45, height: 45)
                                                .clipped()
                                                .clipShape(
                                                    Circle()
                                                )
                                                .overlay(
                                                        Circle().stroke(Color.black, lineWidth: 1) // Adjust the color and lineWidth as needed
                                                    )
                                                
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                        VStack {
                                            Text("\(index.leaders[0].athlete.shortName)")
                                            Text("\(index.leaders[0].value, specifier: "%.1f") \(index.shortDisplayName)")
                                        }
                                    }
                                }
                               
                            }
                        }
                    })
                    .padding(.leading, 25)
                    Text("\(value.competitions[0].competitors[1].team.name) Leaders:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .padding(.top, 15)
                        .font(.title3)
                    ScrollView(.horizontal, content: {
                        HStack(spacing: 30){
                            ForEach(value.competitions[0].competitors[1].leaders, id: \.self) { index in
                                VStack {
                                    Text("\(index.displayName):")
                                        .bold()
                                    HStack {
                                        AsyncImage(url: URL(string: index.leaders[0].athlete.headshot), content: { returnedImage in
                                            returnedImage
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .scaledToFill()
                                                .frame(width: 45, height: 45)
                                                .clipped()
                                                .clipShape(
                                                    Circle()
                                                )
                                                .overlay(
                                                        Circle().stroke(Color.black, lineWidth: 1) // Adjust the color and lineWidth as needed
                                                    )
                                                
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                        VStack {
                                            Text("\(index.leaders[0].athlete.shortName)")
                                            Text("\(index.leaders[0].value, specifier: "%.1f") \(index.shortDisplayName)")
                                        }
                                    }
                                }
                               
                            }
                        }
                    })
                    .padding(.leading, 25)
                    
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    CurrentGameView(value: EventEvent(id: "", uid: "", date: "", name: "Oklahoma City Thunder at Dallas Mavericks", shortName: "", season: EventSeasonEvent(year: 0, type: 0, slug: ""), competitions: [CompetitionEvent(id: "", uid: "", date: "", attendance: 0, type: CompetitionTypeEvent(id: "", abbreviation: ""), timeValid: true, neutralSite: true, conferenceCompetition: true, playByPlayAvailable: true, recent: true, venue: VenueEvent(id: "", fullName: "", address: AddressEvent(city: "", state: ""), indoor: true), competitors: [CompetitorEvent(id: "", uid: "", type: "", order: 0, homeAway: "", team: TeamEvent(id: "", uid: "", location: "", name: "Mavericks", abbreviation: "DAL", displayName: "Dallas Mavericks", shortDisplayName: "DAL", color: "007ac1", alternateColor: "", isActive: true, venue: VenueIDEvent(id: ""), logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/dal.png"), score: "100", statistics: [], records: [], leaders: [LeaderEvent(name: "pointsPerGame", displayName: "Points Per Game", shortDisplayName: "PPG", abbreviation: "PTS", leaders: [AthleteLeaderEvent(displayValue: "20.1", value: 20.130434036254883, athlete: AthleteEvent(id: "4396993", fullName: "Tyrese Haliburton", displayName: "Tyrese Haliburton", shortName: "T. Haliburton", headshot: "https://a.espncdn.com/i/headshots/nba/players/full/4396993.png", jersey: "0", position: PositionEvent(abbreviation: "PG"), team: TeamIDEvent(id: "11"), active: true), team: TeamIDEvent(id: "11"))]), LeaderEvent(name: "pointsPerGame", displayName: "Points Per Game", shortDisplayName: "PPG", abbreviation: "PTS", leaders: [AthleteLeaderEvent(displayValue: "20.1", value: 20.130434036254883, athlete: AthleteEvent(id: "4396993", fullName: "Tyrese Haliburton", displayName: "Tyrese Haliburton", shortName: "T. Haliburton", headshot: "https://a.espncdn.com/i/headshots/nba/players/full/4396993.png", jersey: "0", position: PositionEvent(abbreviation: "PG"), team: TeamIDEvent(id: "11"), active: true), team: TeamIDEvent(id: "11"))])]), CompetitorEvent(id: "", uid: "", type: "", order: 0, homeAway: "", team: TeamEvent(id: "", uid: "", location: "", name: "Timberwolves", abbreviation: "MIL", displayName: "Milwaukee Bucks", shortDisplayName: "MIL", color: "0064b1", alternateColor: "", isActive: true, venue: VenueIDEvent(id: ""), logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/okc.png"), score: "110", statistics: [], records: [], leaders: [])], notes: [], status: StatusEvent(clock: 0, displayClock: "", period: 0, type: StatusTypeEvent(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "Done")), broadcasts: [], format: FormatEvent(regulation: RegulationEvent(periods: 0)), tickets: [], startDate: "", series: SeriesEvent(type: "", title: "", summary: "", completed: true, totalCompetitions: 0, competitors: []), odds: [])], status: StatusEvent(clock: 0, displayClock: "", period: 0, type: StatusTypeEvent(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "Done"))))
}
