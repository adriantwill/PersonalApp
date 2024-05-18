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

//NON APIS
struct TeamInfo: Hashable {
    var name: String
    var code: String
    var nickname: String
    var id: Int
}

struct TeamContainer: Hashable {
    var teams: [TeamInfo]

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


//DRAFT API
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


//NFL RANKINGS API
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

//NBA GAMES API
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

//ESPN NBA TEAM API
struct NBATeamResponse: Codable {
    let team: Team
}

struct Team: Codable {
    let id: String
    let uid: String
    let slug: String
    let location: String
    let name: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
    let color: String
    let alternateColor: String
    let isActive: Bool
    let record: Record
    let nextEvent: [NextEvent]
    let standingSummary: String
}

struct Record: Codable {
    let items: [RecordItem]
}

struct RecordItem: Codable {
    let description: String
    let type: String
    let summary: String
    let stats: [Stat]
}

struct Stat: Codable {
    let name: String
    let value: Double
}

struct NextEvent: Codable {
    let id: String
    let date: String
    let name: String
    let shortName: String
    let season: Season
    let seasonType: SeasonType
    let timeValid: Bool
    let competitions: [Competition]
}

struct Season: Codable {
    let year: Int
    let displayName: String
}

struct SeasonType: Codable {
    let id: String
    let type: Int
    let name: String
    let abbreviation: String
}

struct Competition: Codable {
    let id: String
    let date: String
    let attendance: Int
    let type: CompetitionType
    let timeValid: Bool
    let neutralSite: Bool
    let boxscoreAvailable: Bool
    let ticketsAvailable: Bool
    let competitors: [Competitor]
    let notes: [Note]
    let broadcasts: [Broadcast]
    let tickets: [Ticket]?
    let status: Status
}

struct CompetitionType: Codable {
    let id: String
    let text: String
    let abbreviation: String
    let slug: String
    let type: String
}

struct Competitor: Codable {
    let id: String
    let type: String
    let order: Int
    let homeAway: String
    let team: CompetitorTeam
    let score: Score?
    let record: [Records]?
}

struct CompetitorTeam: Codable {
    let id: String
    let location: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
}

struct Score: Codable {
    let value: Double
    let displayValue: String
}

struct Records: Codable {
    let id: String
    let abbreviation: String?
    let displayName: String
    let shortDisplayName: String
    let description: String
    let type: String
    let displayValue: String
}

struct Note: Codable {
    let type: String
    let headline: String
}

struct Broadcast: Codable {
    let type: BroadcastType
    let market: Market
    let media: Media
    let lang: String
    let region: String
}

struct BroadcastType: Codable {
    let id: String
    let shortName: String
}

struct Market: Codable {
    let id: String
    let type: String
}

struct Media: Codable {
    let shortName: String
}

struct Ticket: Codable {
    let id: String
    let summary: String
    let description: String
    let maxPrice: Double
    let startingPrice: Double
    let numberAvailable: Int
    let totalPostings: Int
}

struct Status: Codable {
    let clock: Double
    let displayClock: String
    let period: Int
    let type: StatusType
}

struct StatusType: Codable {
    let id: String
    let name: String
    let state: String
    let completed: Bool
    let description: String
    let detail: String
    let shortDetail: String
}
