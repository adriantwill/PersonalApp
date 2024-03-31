//
//  GameViewModel.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import Foundation

class GameViewModel: ObservableObject{
    @Published var livegames = [singlegame]()
    @Published var draftteams = [draftteam]()
    @Published var bigboards = [bigboard]()
    @Published var favgames = favgame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philidephia 76ers", hscore: "103", ascore: "104", time: "Thursday March 14 7:00PM", hrecord: "38-8", arecord: "39-7")
    func addummy() {
        livegames.append(singlegame(home: "SAC", away: "LAL", homefull: "Sacramento Kings", awayfull: "Los Angeles Lakers", hscore: "101", ascore: "96", time: "Live"))
        livegames.append(singlegame(home: "LAC", away: "MIL",  homefull: "Los Angeles Clippers", awayfull: "Milwaukee Bucks",hscore: "102", ascore: "97", time: "Live"))
        livegames.append(singlegame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philidephia 76ers", hscore: "103",ascore: "98", time: "Live"))
        livegames.append(singlegame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philidephia 76ers",hscore: "103", ascore: "98", time: "Live"))
        livegames.append(singlegame(home: "SAC", away: "SAC", homefull: "Sacramento Kings", awayfull: "Sacramento Kings",hscore: "103", ascore: "98", time: "Live"))
        livegames.append(singlegame(home: "MIL", away: "PHI", homefull: "Milwaukee Bucks", awayfull: "Philidephia 76ers",hscore: "103", ascore: "98", time: "Live"))
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
    
}



        
