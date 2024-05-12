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
    @Published var favnflteam = ""
    @Published var favnbateam = ""
    @Published var favgames = favgame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philadelphia 76ers", hscore: "103", ascore: "104", time: "April 14 7:00PM", hrecord: "38-8", arecord: "39-7")
    @Published var test: games
    @Published var test1: nflstandings
    @Published var test2: [nfldraft]
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var stadiums = maplocations()

    @Published var nbateam = TeamContainer(teams: [
            Team(name: "Atlanta Hawks", code: "ATL", nickname: "Hawks", id: 1),
            Team(name: "Boston Celtics", code: "BOS", nickname: "Celtics", id: 2),
            Team(name: "Brooklyn Nets", code: "BKN", nickname: "Nets", id: 4),
            Team(name: "Charlotte Hornets", code: "CHA", nickname: "Hornets", id: 5),
            Team(name: "Chicago Bulls", code: "CHI", nickname: "Bulls", id: 6),
            Team(name: "Cleveland Cavaliers", code: "CLE", nickname: "Cavaliers", id: 7),
            Team(name: "Dallas Mavericks", code: "DAL", nickname: "Mavericks", id: 8),
            Team(name: "Denver Nuggets", code: "DEN", nickname: "Nuggets", id: 9),
            Team(name: "Detroit Pistons", code: "DET", nickname: "Pistons", id: 10),
            Team(name: "Golden State Warriors", code: "GSW", nickname: "Warriors", id: 11),
            Team(name: "Houston Rockets", code: "HOU", nickname: "Rockets", id: 14),
            Team(name: "Indiana Pacers", code: "IND", nickname: "Pacers", id: 15),
            Team(name: "Los Angeles Clippers", code: "LAC", nickname: "Clippers", id: 16),
            Team(name: "Los Angeles Lakers", code: "LAL", nickname: "Lakers", id: 17),
            Team(name: "Memphis Grizzlies", code: "MEM", nickname: "Grizzlies", id: 19),
            Team(name: "Miami Heat", code: "MIA", nickname: "Heat", id: 20),
            Team(name: "Milwaukee Bucks", code: "MIL", nickname: "Bucks", id: 21),
            Team(name: "Minnesota Timberwolves", code: "MIN", nickname: "Timberwolves", id: 22),
            Team(name: "New Orleans Pelicans", code: "NOP", nickname: "Pelicans", id: 23),
            Team(name: "New York Knicks", code: "NYK", nickname: "Knicks", id: 24),
            Team(name: "Oklahoma City Thunder", code: "OKC", nickname: "Thunder", id: 25),
            Team(name: "Orlando Magic", code: "ORL", nickname: "Magic", id: 26),
            Team(name: "Philadelphia 76ers", code: "PHI", nickname: "76ers", id: 27),
            Team(name: "Phoenix Suns", code: "PHX", nickname: "Suns", id: 28),
            Team(name: "Portland Trail Blazers", code: "POR", nickname: "Trail Blazers", id: 29),
            Team(name: "Sacramento Kings", code: "SAC", nickname: "Kings", id: 30),
            Team(name: "San Antonio Spurs", code: "SAS", nickname: "Spurs", id: 31),
            Team(name: "Toronto Raptors", code: "TOR", nickname: "Raptors", id: 38),
            Team(name: "Utah Jazz", code: "UTA", nickname: "Jazz", id: 40),
            Team(name: "Washington Wizards", code: "WAS", nickname: "Wizards", id: 41)
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
        } else if whichapi == 2{
            request.addValue("application/json", forHTTPHeaderField: "accept")
            request.addValue("Bearer \(Secrets.collegeapi)", forHTTPHeaderField: "Authorization")
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
        if (long == "Scheduled") {
            let utcFormatter = DateFormatter()
            utcFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            utcFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC time zone
            
            // Convert the string to a Date object
            guard let date = utcFormatter.date(from: utcDate) else {
                return "Invalid date"
            }
            
            // Create a DateFormatter to output the date in Pacific Time
            let pacificFormatter = DateFormatter()
            pacificFormatter.dateFormat = "HH:mm"
            pacificFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles") // Pacific Time zone
            
            // Format the date into Pacific Time string
            return pacificFormatter.string(from: date)
        } else if (long == "Finished") {
            return "Finished"
        } else {
            return "Live"
        }
        
    }
}

func findFirstScheduledGame(games: [response]) -> response? {
    return games.first { $0.status.long == "Scheduled" }
}



        
