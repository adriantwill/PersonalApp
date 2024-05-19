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

//VIEW STRUCTS

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

//NBA RANKINGS API SPORTS

struct NBAStandings: Codable, Hashable {
    let get: String
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [TeamResponse]
}

struct Parameters: Codable, Hashable {
    let league: String
    let season: String
}

struct TeamResponse: Codable, Hashable {
    let league: String
    let season: Int
    let team: NBATeamRankings
    let conference: Conference
    let division: Division
    let win: NBARecordRankings
    let loss: NBARecordRankings
    let gamesBehind: String?
    let streak: Int
    let winStreak: Bool
    let tieBreakerPoints: Int?
}

struct NBATeamRankings: Codable, Hashable {
    let id: Int
    let name: String
    let nickname: String
    let code: String
    let logo: String
}

struct Conference: Codable, Hashable {
    let name: String
    let rank: Int
    let win: Int
    let loss: Int
}

struct Division: Codable, Hashable {
    let name: String
    let rank: Int
    let win: Int
    let loss: Int
    let gamesBehind: String?
}

struct NBARecordRankings: Codable, Hashable {
    let home: Int
    let away: Int
    let total: Int
    let percentage: String
    let lastTen: Int
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

//ESPN SCHEDULED API

// Root struct
struct NBADataEvent: Codable, Hashable {
    let leagues: [LeagueEvent]
    let season: SeasonEvent
    let day: DayEvent
    let events: [EventEvent]
}

// League struct
struct LeagueEvent: Codable, Hashable {
    let id: String
    let uid: String
    let name: String
    let abbreviation: String
    let slug: String
    let season: LeagueSeasonEvent
    let logos: [LogoEvent]
    let calendarType: String
    let calendarIsWhitelist: Bool
    let calendarStartDate: String
    let calendarEndDate: String
    let calendar: [String]
}

struct LeagueSeasonEvent: Codable, Hashable {
    let year: Int
    let startDate: String
    let endDate: String
    let displayName: String
    let type: SeasonTypeEvent
}

struct SeasonTypeEvent: Codable, Hashable {
    let id: String
    let type: Int
    let name: String
    let abbreviation: String
}

// Logo struct
struct LogoEvent: Codable, Hashable {
    let href: String
    let width: Int
    let height: Int
    let alt: String
    let rel: [String]
    let lastUpdated: String
}

// Season struct
struct SeasonEvent: Codable, Hashable {
    let type: Int
    let year: Int
}

// Day struct
struct DayEvent: Codable, Hashable {
    let date: String
}

// Event struct
struct EventEvent: Codable, Hashable {
    let id: String
    let uid: String
    let date: String
    let name: String
    let shortName: String
    let season: EventSeasonEvent
    let competitions: [CompetitionEvent]
    let status: StatusEvent
}

struct EventSeasonEvent: Codable, Hashable {
    let year: Int
    let type: Int
    let slug: String
}

struct CompetitionEvent: Codable, Hashable {
    let id: String
    let uid: String
    let date: String
    let attendance: Int
    let type: CompetitionTypeEvent
    let timeValid: Bool
    let neutralSite: Bool
    let conferenceCompetition: Bool
    let playByPlayAvailable: Bool
    let recent: Bool
    let venue: VenueEvent
    let competitors: [CompetitorEvent]
    let notes: [NoteEvent]
    let status: StatusEvent
    let broadcasts: [BroadcastEvent]
    let format: FormatEvent
    let tickets: [TicketEvent]?
    let startDate: String
    let series: SeriesEvent
    let odds: [OddsEvent]?
}

struct CompetitionTypeEvent: Codable, Hashable {
    let id: String
    let abbreviation: String
}

struct VenueEvent: Codable, Hashable {
    let id: String
    let fullName: String
    let address: AddressEvent
    let indoor: Bool
}

struct AddressEvent: Codable, Hashable {
    let city: String
    let state: String
}

struct CompetitorEvent: Codable, Hashable {
    let id: String
    let uid: String
    let type: String
    let order: Int
    let homeAway: String
    let team: TeamEvent
    let score: String
    let statistics: [StatisticEvent]
    let records: [RecordEvent]
    let leaders: [LeaderEvent]
}

struct TeamEvent: Codable, Hashable {
    let id: String
    let uid: String
    let location: String
    let name: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
    let color: String
    let alternateColor: String
    let isActive: Bool
    let venue: VenueIDEvent
    let logo: String
}

struct VenueIDEvent: Codable, Hashable {
    let id: String
}

struct StatisticEvent: Codable, Hashable {
    let name: String
    let abbreviation: String
    let displayValue: String
    let rankDisplayValue: String?
}

struct RecordEvent: Codable, Hashable {
    let name: String
    let abbreviation: String?
    let type: String
    let summary: String
}

struct LeaderEvent: Codable, Hashable {
    let name: String
    let displayName: String
    let shortDisplayName: String
    let abbreviation: String
    let leaders: [AthleteLeaderEvent]
}

struct AthleteLeaderEvent: Codable, Hashable {
    let displayValue: String
    let value: Double
    let athlete: AthleteEvent
    let team: TeamIDEvent
}

struct AthleteEvent: Codable, Hashable {
    let id: String
    let fullName: String
    let displayName: String
    let shortName: String
    let headshot: String
    let jersey: String
    let position: PositionEvent
    let team: TeamIDEvent
    let active: Bool
}

struct TeamIDEvent: Codable, Hashable {
    let id: String
}

struct PositionEvent: Codable, Hashable {
    let abbreviation: String
}

struct LinkEvent: Codable, Hashable {
    let rel: [String]
    let href: String
    let text: String?
    let isExternal: Bool?
    let isPremium: Bool?
}

struct NoteEvent: Codable, Hashable {
    let type: String
    let headline: String
}

struct StatusEvent: Codable, Hashable {
    let clock: Int
    let displayClock: String
    let period: Int
    let type: StatusTypeEvent
}

struct StatusTypeEvent: Codable, Hashable {
    let id: String
    let name: String
    let state: String
    let completed: Bool
    let description: String
    let detail: String
    let shortDetail: String
}

struct BroadcastEvent: Codable, Hashable {
    let market: String
    let names: [String]
}

struct FormatEvent: Codable, Hashable {
    let regulation: RegulationEvent
}

struct RegulationEvent: Codable, Hashable {
    let periods: Int
}

struct TicketEvent: Codable, Hashable {
    let summary: String
    let numberAvailable: Int
}

struct SeriesEvent: Codable, Hashable {
    let type: String
    let title: String
    let summary: String
    let completed: Bool
    let totalCompetitions: Int
    let competitors: [SeriesCompetitorEvent]
}

struct SeriesCompetitorEvent: Codable, Hashable {
    let id: String
    let uid: String
    let wins: Int
    let ties: Int
    let href: String
}

struct BroadcastTypeEvent: Codable, Hashable {
    let id: String
    let shortName: String
}

struct BroadcastMarketEvent: Codable, Hashable {
    let id: String
    let type: String
}

struct BroadcastMediaEvent: Codable, Hashable {
    let shortName: String
}

struct OddsEvent: Codable, Hashable {
    let provider: ProviderEvent
    let details: String
    let overUnder: Double
    let spread: Double
    let awayTeamOdds: TeamOddsEvent
    let homeTeamOdds: TeamOddsEvent
    let open: OddsDetailsEvent
    let current: OddsDetailsEvent
}

struct ProviderEvent: Codable, Hashable {
    let id: String
    let name: String
    let priority: Int
}

struct TeamOddsEvent: Codable, Hashable {
    let favorite: Bool
    let underdog: Bool
    let team: TeamInfoEvent
}

struct TeamInfoEvent: Codable, Hashable {
    let id: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
}

struct OddsDetailsEvent: Codable, Hashable {
    let over: OddsValueEvent
    let under: OddsValueEvent
    let total: OddsTotalEvent
}

struct OddsValueEvent: Codable, Hashable {
    let value: Double
    let displayValue: String
    let alternateDisplayValue: String
    let decimal: Double
    let fraction: String
    let american: String
}

struct OddsTotalEvent: Codable, Hashable {
    let alternateDisplayValue: String
    let american: String
}

