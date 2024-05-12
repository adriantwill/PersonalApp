//
//  GameModel.swift
//  Project
//
//  Created by Adrian Will on 3/13/24.
//

import Foundation
import UIKit
import SwiftData
import SwiftUI
import MapKit

struct Team: Hashable {
    var name: String
    var code: String
    var nickname: String
    var id: Int
}

struct TeamContainer: Hashable {
    var teams: [Team]

    func find(identifier: String, entered: String, returned: String) -> String {
        for team in teams {
            if entered == "Name" {
                if team.name == identifier {
                    if returned == "Id"{
                        return String(team.id)
                    }
                }
            }
            
        }
        return ""
    }
}

struct maplocations {
    var warriors: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.768009, longitude: -122.387787)
    var fortyniners: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.4033, longitude: -121.9694)
}

struct bigboard: Hashable {
    var name: String
    var position: String
    var school: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(name)
        }
}

struct draftteam: Hashable {
    var name: String
    var abrevname: String
    var winloss: String
    var sos: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(name)
        }
}

struct favgame {
    var home: String
    var away: String
    var homefull: String
    var awayfull: String
    var hscore: String
    var ascore: String
    var hlogopic: Image { // calculable property not used by hashing
           Image(homefull)
        }
    var alogopic: Image { // calculable property not used by hashing
           Image(awayfull)
        }
    var time: String
    var hrecord: String
    var arecord: String
}

@Model
class swiftnfldraft {
    var collegeTeam: String
    var nflTeam: String
    @Attribute(.unique) var overall: Int
    var name: String
    var position: String
    init(from nfldraft: nfldraft) {
        self.collegeTeam = nfldraft.collegeTeam
        self.nflTeam = nfldraft.nflTeam
        self.overall = nfldraft.overall
        self.name = nfldraft.name
        self.position = nfldraft.position
    }
}


struct nfldraft: Decodable, Hashable {
    var collegeTeam: String
    var nflTeam: String
    var overall: Int
    var name: String
    var position: String
}

@Model
class swiftnflresponse {
    var division: String
    var position: Int
    @Attribute(.unique) var team: String
    var won: Int
    var lost: Int
    var ties: Int
    init(from nflresponse: nflresponse) {
        self.division = nflresponse.division
        self.position = nflresponse.position
        self.team = nflresponse.team.name
        self.won = nflresponse.won
        self.lost = nflresponse.lost
        self.ties = nflresponse.ties
    }
}

struct nflstandings: Decodable, Hashable {
    var results: Int
    var response: [nflresponse]
}

struct nflresponse: Decodable, Hashable{
    var division: String
    var position: Int
    var team: nflteam
    var won: Int
    var lost: Int
    var ties: Int
}

struct nflteam: Decodable, Hashable{
    var id: Int
    var name: String
}

@Model
class swiftscores {
    @Attribute(.unique) var iden: Int
    var hteam: String
    var ateam: String
    var hteamcode: String
    var ateamcode: String
    var hscore: Int
    var ascore: Int
    var start: String
    var long: String
    init(from response: response) {
        self.iden = response.id
        self.hteam = response.teams.home.name
        self.ateam = response.teams.visitors.name
        self.hteamcode = response.teams.home.code
        self.ateamcode = response.teams.visitors.code
        self.hscore = response.scores.home.points ?? 0
        self.ascore = response.scores.visitors.points ?? 0
        self.start = response.date.start
        self.long = response.status.long
    }
}

//nba games
struct games: Decodable, Hashable {
    var results: Int
    var response: [response]
}

struct response: Decodable, Hashable{
    var id: Int
    var league: String
    var season: Int
    var date: date
    var stage: Int
    var status: status
    var periods: periods
    var teams: teams
    var scores: scores
}

struct date: Decodable, Hashable{
    var start: String
    var end: String?
    var duration: String?
}

struct status: Decodable, Hashable{
    var clock: String?
    var halftime: Bool
    var short: Int
    var long: String
}

struct periods: Decodable, Hashable{
    var current: Int
    var total: Int
    var endOfPeriod: Bool
}

struct teams: Decodable, Hashable {
    var visitors: teamid
    var home: teamid
}

struct teamid: Decodable, Hashable{
    var id: Int
    var name: String
    var nickname: String
    var code: String
    var logo: String
}

struct scores: Decodable, Hashable{
    var visitors: teamscores
    var home: teamscores
}

struct teamscores: Decodable, Hashable{
    var win: Int
    var loss: Int
    var linescore: [String]
    var points: Int?
}
