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
    @Published var favgames = favgame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philidephia 76ers", hscore: "103", ascore: "104", time: "Thursday March 14 7:00PM", hrecord: "38-8", arecord: "39-7")
    @Published var test: games
    @Published var currdate = String()
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var stadiums = maplocations()
    init()
    {
        let series = series(win: 0, loss: 0)
        let teamscore = teamscores(win: 0, loss: 0, linescore: [""], points: 0)
        let scores = scores(visitors: teamscore, home: teamscore)
        let teamid = teamid(id: 0, name: "", nickname: "", code: "", logo: "")
        let team = teams(visitors: teamid, home: teamid)
        let arena = arena(name: "", city: "", state: "")
        let period = periods(current: 0, total: 0, endOfPeriod: true)
        let stat = status(halftime: true, short: 0, long: "")
        let dat = date(start: "")
        let res = response(id: 0, league: "", season: 0, date: dat, stage: 0, status: stat, periods: period, arena: arena, teams: team, scores: scores, officials: [""])
        let parms = parameters(date: "")
        test = games(get: "", errors: [""], results: 0, response: [res])
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
    func getJsonData() {
        
        
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://v2.nba.api-sports.io/games?date=2024-04-13")!,timeoutInterval: Double.infinity)
        request.addValue("a439e25a4b4de1897e5deab481669b4c", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v2.nba.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")

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
                let decodedData = try JSONDecoder().decode(games.self, from: data)
                self.test = decodedData
                
                
            } catch {
                print("error: \(error)")
            }
          //print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    
    func getDate(){
        let currentDate = Date()
        let oneDay = DateComponents(day: 1)
        let dateFormatter = DateFormatter()
        let tomorrow = Calendar.current.date(byAdding: oneDay, to: currentDate)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currdate = dateFormatter.string(from: tomorrow ?? currentDate)
    }
    
}



        
