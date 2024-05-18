//
//  GameViewModel.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import Foundation
import MapKit
import _MapKit_SwiftUI


class GameViewModel: ObservableObject{
    @Published var draftteams = [draftteam]()
    @Published var bigboards = [bigboard]()
    @Published var searchCity = "Seattle"
    @Published var searchText = ""
    @Published var favnflteam = TeamInfo(name: "", code: "", nickname: "", id: -1)
    @Published var favnbateam = TeamInfo(name: "", code: "", nickname: "", id: -1)
    @Published var test: games
    @Published var test1: nflstandings
    @Published var test2: [nfldraft]
    @Published var test3: NBATeamResponse
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var stadiums = maplocations()

    @Published var nbateam = TeamContainer(teams: [
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
        TeamInfo(name: "Utah Jazz", code: "UTA", nickname: "Jazz", id: 40),
        TeamInfo(name: "Washington Wizards", code: "WAS", nickname: "Wizards", id: 41)
    ])

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
        let teamscore = teamscores(win: 100, loss: 90, linescore: [""], points: 0)
        let scores = scores(visitors: teamscore, home: teamscore)
        let vteamid = teamid(id: 0, name: "LA Clippers", nickname: "Clippers", code: "LAC", logo: "")
        let hteamid = teamid(id: 0, name: "Dallas Mavericks", nickname: "Mavericks", code: "MAV", logo: "")
        let team = teams(visitors: vteamid, home: hteamid)
        let period = periods(current: 0, total: 0, endOfPeriod: true)
        let stat = status(halftime: true, short: 0, long: "")
        let dat = date(start: "2024-05-04T01:30:00.000Z")
        let res = response(id: 0, league: "", season: 0, date: dat, stage: 0, status: stat, periods: period, teams: team, scores: scores)
        test = games(results: 0, response: [res])
        let nflteam = nflteam(id: 0, name: "Tennessee Titans")
        let responsenfl = nflresponse(division: "AFC South", position: 4, team: nflteam, won: 0, lost: 0, ties: 0)
        test1 = nflstandings(results: 0, response: [responsenfl])
        test2 = [nfldraft(collegeTeam: "USC", nflTeam: "Carolina", overall: 0, name: "Caleb Williams", position: "QB")]
        test3 = NBATeamResponse(team: Team(id: "", uid: "", slug: "", location: "", name: "", abbreviation: "", displayName: "", shortDisplayName: "", color: "", alternateColor: "", isActive: true, record: Record(items: [RecordItem(description: "", type: "", summary: "", stats: [Stat(name: "", value: 0.0)])]), nextEvent: [NextEvent(id: "", date: "", name: "", shortName: "", season: Season(year: 0, displayName: ""), seasonType: SeasonType(id: "", type: 0, name: "", abbreviation: ""), timeValid: true, competitions: [Competition(id: "", date: "", attendance: 0, type: CompetitionType(id: "", text: "", abbreviation: "", slug: "", type: ""), timeValid: true, neutralSite: true, boxscoreAvailable: true, ticketsAvailable: true, competitors: [Competitor(id: "", type: "", order: 0, homeAway: "", team: CompetitorTeam(id: "", location: "", abbreviation: "", displayName: "", shortDisplayName: ""), score: Score(value: 0.0, displayValue: ""), record: [Records(id: "", abbreviation: "", displayName: "", shortDisplayName: "", description: "", type: "", displayValue: "")]), Competitor(id: "", type: "", order: 0, homeAway: "", team: CompetitorTeam(id: "", location: "", abbreviation: "", displayName: "", shortDisplayName: ""), score: Score(value: 0.0, displayValue: ""), record: [Records(id: "", abbreviation: "", displayName: "", shortDisplayName: "", description: "", type: "", displayValue: "")])], notes: [Note(type: "", headline: "")], broadcasts: [Broadcast(type: BroadcastType(id: "", shortName: ""), market: Market(id: "", type: ""), media: Media(shortName: ""), lang: "", region: "")], tickets: [Ticket(id: "", summary: "", description: "", maxPrice: 0.0, startingPrice: 0.0, numberAvailable: 0, totalPostings: 0)], status: Status(clock: 0.0, displayClock: "", period: 0, type: StatusType(id: "", name: "", state: "", completed: true, description: "", detail: "", shortDetail: "")))])], standingSummary: ""))
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
                    let decodedData = try JSONDecoder().decode(games.self, from: data)
                    DispatchQueue.main.async {
                        self.test = decodedData
                    }
                } else if whichapi == 1{
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
                outputFormatter.dateFormat = "MMM d h:mm a 'PST'"
                outputFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
                
                // Convert the Date object to the desired output format
                return outputFormatter.string(from: date)
        } else if (long == "Finished" || long == "STATUS_FINAL") {
            return "Finished"
        } else {
            return "Live"
        }
    }
}


        
