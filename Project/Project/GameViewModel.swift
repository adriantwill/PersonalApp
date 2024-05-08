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
    @Published var favgames = favgame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philadelphia 76ers", hscore: "103", ascore: "104", time: "April 14 7:00PM", hrecord: "38-8", arecord: "39-7")
    @Published var test: games
    @Published var test1: nflstandings
    @Published var test2: [nfldraft]
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var stadiums = maplocations()
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
    func addummy() {
        draftteams.append(draftteam(name: "Carolina Panthers", abrevname: "CAR", winloss: "2-15", sos: "0.0522"))
        draftteams.append(draftteam(name: "Washington Commanders", abrevname: "WAS", winloss: "3-14", sos: "0.0522"))
        draftteams.append(draftteam(name: "New England Patriots", abrevname: "NWE", winloss: "3-14", sos: "0.0522"))
        draftteams.append(draftteam(name: "Arizona Cardinals", abrevname: "ARZ", winloss: "4-13", sos: "0.0522"))
        draftteams.append(draftteam(name: "Los Angeles Chargers", abrevname: "LACH", winloss: "5-12", sos: "0.0522"))
        draftteams.append(draftteam(name: "New York Giants", abrevname: "NYG", winloss: "6-11", sos: "0.0522"))
        draftteams.append(draftteam(name: "Tennessee Titans", abrevname: "TEN", winloss: "7-10", sos: "0.0522"))
        bigboards.append(bigboard(name: "Caleb Williams", position: "QB", school: "USC"))
        bigboards.append(bigboard(name: "Drake Maye", position: "QB", school: "UNC"))
        bigboards.append(bigboard(name: "Jayden Daniels", position: "QB", school: "LSU"))
        bigboards.append(bigboard(name: "Marvin Harrison Jr.", position: "WR", school: "OSU"))
        bigboards.append(bigboard(name: "Malik Nabers", position: "WR", school: "LSU"))
        bigboards.append(bigboard(name: "Rome Odunze", position: "WR", school: "Washington"))
        bigboards.append(bigboard(name: "Joe Alt", position: "OT", school: "Notre Dame"))
        bigboards.append(bigboard(name: "Dallas Turner", position: "LB", school: "Alabama"))
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
                    self.test = decodedData
                } else if whichapi == 1{
                    let decodedData = try JSONDecoder().decode(nflstandings.self, from: data)
                    self.test1 = decodedData
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



        
