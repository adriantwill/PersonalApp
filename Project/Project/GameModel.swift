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
class gamesdata {
    var hname: String
    var aname: String
    var hcode: String
    var acode: String
    var hscore: Int
    var ascore: Int
    init(hname: String, aname: String, hcode: String, acode: String, hscore: Int, ascore: Int) {
        self.hname = hname
        self.aname = aname
        self.hcode = hcode
        self.acode = acode
        self.hscore = hscore
        self.ascore = ascore
    }
}

struct nfl: Decodable, Hashable {
    var results: String
    var response: [nflresponse]
}

struct nflresponse: Decodable, Hashable{
    
}


struct games: Decodable, Hashable {
    var get: String
    var errors: [String]
    var results: Int
    var response: [response]
}

struct parameters: Decodable, Hashable{
    var date: String
}

struct response: Decodable, Hashable{
    var id: Int
    var league: String
    var season: Int
    var date: date
    var stage: Int
    var status: status
    var periods: periods
    var arena: arena
    var teams: teams
    var scores: scores
    var officials: [String]
    var timesTied: String?
    var leadChanges: String?
    var nuggest: String?
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

struct arena: Decodable, Hashable{
    var name: String
    var city: String
    var state: String
    var country: String?
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
    var points: Int
}

struct series: Decodable, Hashable{
    var win: Int
    var loss: Int
}
