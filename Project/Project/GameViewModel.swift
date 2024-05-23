//
//  GameViewModel.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUI


class GameViewModel: ObservableObject{
    @Published var searchCity = "Seattle"
    @Published var searchText = ""
    @Published var test0: NBAStandings
    @Published var test1: nflstandings
    @Published var test2: [nfldraft]
    @Published var test3: NBATeamResponse
    @Published var test4: NBADataEvent
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var stadiums = maplocations()

    @Published var nbateam = [
        TeamInfo(name: "Atlanta Hawks", code: "ATL", nickname: "Hawks", id: 1),
        TeamInfo(name: "Boston Celtics", code: "BOS", nickname: "Celtics", id: 2),
        TeamInfo(name: "Brooklyn Nets", code: "BKN", nickname: "Nets", id: 4),
        TeamInfo(name: "Charlotte Hornets", code: "CHA", nickname: "Hornets", id: 5),
        TeamInfo(name: "Chicago Bulls", code: "CHI", nickname: "Bulls", id: 6),
        TeamInfo(name: "Cleveland Cavaliers", code: "CLE", nickname: "Cavaliers", id: 7),
        TeamInfo(name: "Dallas Mavericks", code: "DAL", nickname: "Mavericks", id: 8),
        TeamInfo(name: "Denver Nuggets", code: "DEN", nickname: "Nuggets", id: 9),
        TeamInfo(name: "Detroit Pistons", code: "DET", nickname: "Pistons", id: 10),
        TeamInfo(name: "Golden State Warriors", code: "GSW", nickname: "Warriors", id: 11),
        TeamInfo(name: "Houston Rockets", code: "HOU", nickname: "Rockets", id: 14),
        TeamInfo(name: "Indiana Pacers", code: "IND", nickname: "Pacers", id: 15),
        TeamInfo(name: "Los Angeles Clippers", code: "LAC", nickname: "Clippers", id: 16),
        TeamInfo(name: "Los Angeles Lakers", code: "LAL", nickname: "Lakers", id: 17),
        TeamInfo(name: "Memphis Grizzlies", code: "MEM", nickname: "Grizzlies", id: 19),
        TeamInfo(name: "Miami Heat", code: "MIA", nickname: "Heat", id: 20),
        TeamInfo(name: "Milwaukee Bucks", code: "MIL", nickname: "Bucks", id: 21),
        TeamInfo(name: "Minnesota Timberwolves", code: "MIN", nickname: "Timberwolves", id: 22),
        TeamInfo(name: "New Orleans Pelicans", code: "NOP", nickname: "Pelicans", id: 23),
        TeamInfo(name: "New York Knicks", code: "NYK", nickname: "Knicks", id: 24),
        TeamInfo(name: "Oklahoma City Thunder", code: "OKC", nickname: "Thunder", id: 25),
        TeamInfo(name: "Orlando Magic", code: "ORL", nickname: "Magic", id: 26),
        TeamInfo(name: "Philadelphia 76ers", code: "PHI", nickname: "76ers", id: 27),
        TeamInfo(name: "Phoenix Suns", code: "PHX", nickname: "Suns", id: 28),
        TeamInfo(name: "Portland Trail Blazers", code: "POR", nickname: "Trail Blazers", id: 29),
        TeamInfo(name: "Sacramento Kings", code: "SAC", nickname: "Kings", id: 30),
        TeamInfo(name: "San Antonio Spurs", code: "SAS", nickname: "Spurs", id: 31),
        TeamInfo(name: "Toronto Raptors", code: "TOR", nickname: "Raptors", id: 38),
        TeamInfo(name: "Utah Jazz", code: "UTH", nickname: "Jazz", id: 40),
        TeamInfo(name: "Washington Wizards", code: "WAS", nickname: "Wizards", id: 41)
    ]

    @Published var nflteams = [
        "Arizona Cardinals",
        "Atlanta Falcons",
        "Baltimore Ravens",
        "Buffalo Bills",
        "Carolina Panthers",
        "Chicago Bears",
        "Cincinnati Bengals",
        "Cleveland Browns",
        "Dallas Cowboys",
        "Denver Broncos",
        "Detroit Lions",
        "Green Bay Packers",
        "Houston Texans",
        "Indianapolis Colts",
        "Jacksonville Jaguars",
        "Kansas City Chiefs",
        "Las Vegas Raiders",
        "Los Angeles Chargers",
        "Los Angeles Rams",
        "Miami Dolphins",
        "Minnesota Vikings",
        "New England Patriots",
        "New Orleans Saints",
        "New York Giants",
        "New York Jets",
        "Philadelphia Eagles",
        "Pittsburgh Steelers",
        "San Francisco 49ers",
        "Seattle Seahawks",
        "Tampa Bay Buccaneers",
        "Tennessee Titans",
        "Washington Commanders"
    ]
    init()
    {
        test0 = NBAStandings(get: "", parameters: Parameters(league: "", season: ""), errors: [], results: 0, response: [])
        test1 = nflstandings(results: 0, response: [])
        test2 = []
      //  test3 = NBATeamResponse(team: Team(id: "", uid: "", slug: "", location: "", name: "", abbreviation: "", displayName: "", shortDisplayName: "", color: "", alternateColor: "", isActive: true, logos: [], record: Record(items: []), nextEvent: [], standingSummary: ""))
        test3 = NBATeamResponse(team: Team(id: "", uid: "", slug: "", location: "", name: "", abbreviation: "", displayName: "Chicago Bulls", shortDisplayName: "", color: "0e2240", alternateColor: "fec524",  isActive: true, logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")], record: Record(items: [RecordItem(description: "", type: "", summary: "57-25", stats: [Stat(name: "", value: 0.0), Stat(name: "", value: 0.0), Stat(name: "", value: 109.597565), Stat(name: "", value: 114.85366), Stat(name: "", value: 0.0), Stat(name: "", value: 5.300000000000011)])]), nextEvent: [NextEvent(id: "", date: "2024-05-20T00:00Z", name: "", shortName: "", season: Season(year: 0, displayName: ""), seasonType: SeasonType(id: "", type: 0, name: "", abbreviation: ""), timeValid: true, competitions: [Competition(id: "", date: "", attendance: 0, type: CompetitionType(id: "", text: "", abbreviation: "", slug: "", type: ""), timeValid: true, neutralSite: true, boxscoreAvailable: true, ticketsAvailable: true, competitors: [Competitor(id: "", type: "", order: 0, homeAway: "away", team: CompetitorTeam(id: "", location: "Minnesota", abbreviation: "MIA", displayName: "Miami Heat", shortDisplayName: "MIA", logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")]), score: Score(value: 0.0, displayValue: "100"), record: []), Competitor(id: "", type: "", order: 0, homeAway: "away", team: CompetitorTeam(id: "", location: "Minnesota", abbreviation: "CHI", displayName: "Chicago Bulls", shortDisplayName: "Timberwolves", logos: [Logo(href: "https://a.espncdn.com/i/teamlogos/nba/500/den.png", width: 0, height: 0, alt: "", rel: [], lastUpdated: "")]), score: Score(value: 0.0, displayValue: "110"), record: [])], notes: [], broadcasts: [], tickets: [], status: Status(clock: 0.0, displayClock: "", period: 0, type: StatusType(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "5/19 - 8:00 PM EDT")))])], standingSummary: ""))
        test4 = NBADataEvent(leagues: [], season: SeasonEvent(type: 0, year: 0), day: DayEvent(date: ""), events: [])
        //test4 = NBADataEvent(leagues: [], season: SeasonEvent(type: 0, year: 0), day: DayEvent(date: ""), events: [EventEvent(id: "", uid: "", date: "", name: "", shortName: "", season: EventSeasonEvent(year: 0, type: 0, slug: ""), competitions: [CompetitionEvent(id: "", uid: "", date: "", attendance: 0, type: CompetitionTypeEvent(id: "", abbreviation: ""), timeValid: true, neutralSite: true, conferenceCompetition: true, playByPlayAvailable: true, recent: true, venue: VenueEvent(id: "", fullName: "", address: AddressEvent(city: "", state: ""), indoor: true), competitors: [CompetitorEvent(id: "", uid: "", type: "", order: 0, homeAway: "", team: TeamEvent(id: "", uid: "", location: "", name: "Dallas Mavericks", abbreviation: "DAL", displayName: "Dallas Mavericks", shortDisplayName: "DAL", color: "", alternateColor: "", isActive: true, venue: VenueIDEvent(id: ""), logo: ""), score: "100", statistics: [], records: [], leaders: []), CompetitorEvent(id: "", uid: "", type: "", order: 0, homeAway: "", team: TeamEvent(id: "", uid: "", location: "", name: "Dallas Mavericks", abbreviation: "MIL", displayName: "Milwaukee Bucks", shortDisplayName: "MIL", color: "", alternateColor: "", isActive: true, venue: VenueIDEvent(id: ""), logo: ""), score: "100", statistics: [], records: [], leaders: [])], notes: [], status: StatusEvent(clock: 0, displayClock: "", period: 0, type: StatusTypeEvent(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "Done")), broadcasts: [], format: FormatEvent(regulation: RegulationEvent(periods: 0)), tickets: [], startDate: "", series: SeriesEvent(type: "", title: "", summary: "", completed: true, totalCompetitions: 0, competitors: []), odds: [])], status: StatusEvent(clock: 0, displayClock: "", period: 0, type: StatusTypeEvent(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "Done")))])
        
    }

    func getJsonData(api: String, whichapi: Int) {
        
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: api)!,timeoutInterval: Double.infinity)
        
        if whichapi == 0{
            request.addValue(Secrets.apisportsio, forHTTPHeaderField: "x-rapidapi-key")
            request.addValue("v2.nba.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        } else if whichapi == 1 {
            request.addValue(Secrets.apisportsio, forHTTPHeaderField: "x-rapidapi-key")
            request.addValue("v1.american-football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        }
    
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            do {
                if whichapi == 0{
                    let decodedData = try JSONDecoder().decode(NBAStandings.self, from: data)
                    DispatchQueue.main.async {
                        self.test0 = decodedData
                    }
                }
                else if whichapi == 1{
                    let decodedData = try JSONDecoder().decode(nflstandings.self, from: data)
                    DispatchQueue.main.async {
                        self.test1 = decodedData
                    }
                } else if whichapi == 2{
                    let decodedData = try JSONDecoder().decode([nfldraft].self, from: data)
                    self.test2 = decodedData
                } else if whichapi == 3{
                    let decodedData = try JSONDecoder().decode(NBATeamResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.test3 = decodedData
                    }
                }
                else if whichapi == 4{
                   let decodedData = try JSONDecoder().decode(NBADataEvent.self, from: data)
                   DispatchQueue.main.async {
                       self.test4 = decodedData
                   }
                } else{
                    print("major error")
                }
            } catch {
                print("error: \(error)")
            }
          //print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
       
    func getDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: currentDate)
    }
    
    func convertUTCtoPacificTime(utcDate: String, long: String) -> String {
        // Create a DateFormatter to parse the UTC date string
        if (long == "Scheduled" || long == "STATUS_SCHEDULED") {
                // Define the input date format
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
                inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
                
                // Convert the input date string to a Date object
                guard let date = inputFormatter.date(from: utcDate) else {
                    return "Invalid date"
                }
                
                // Define the output date format
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "MMM d h:mma 'PST'"
                outputFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
                
                // Convert the Date object to the desired output format
                return outputFormatter.string(from: date)
        } else if (long == "Finished" || long == "STATUS_FINAL") {
            return "Finished"
        } else {
            return "Live"
        }
    }
    
    func convertDateString(_ input: String) -> String {
        // Split the input string to separate the date and time parts
        let components = input.split(separator: "-")
        guard components.count > 1 else {
            return "bad"
        }
        
        // Trim any leading/trailing whitespaces and return the time part
        let timePart = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
        return timePart
    }
    
    func index(fullname: String) -> Int {
        for (index, team) in nbateam.enumerated() {
            if team.name == fullname {
                return index
            }
        }
        return -1
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 4), (int >> 4 * 4) & 0xF, int & 0xF)
            self.init(red: Double(r) / 15, green: Double(g) / 15, blue: Double(b) / 15, opacity: Double(a) / 255)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
        default:
            self.init(red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}
        
