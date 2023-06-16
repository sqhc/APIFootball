//
//  FixturesDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/16/23.
//

import Foundation

struct Fixtures: Codable{
    let response: [Fixture]?
}

struct Fixture: Codable{
    let fixture: FixtureInfo?
    let league: FixtureLeague?
    let teams: FixtureTeams?
    let goals: FixtureGoals?
}

struct FixtureInfo: Codable{
    let id: Int?
    let referee: String?
    let timezone: String?
    let date: String?
    let venue: FixtureVenue?
    let status: FixtureStatus?
}

struct FixtureVenue: Codable{
    let id: Int?
    let name: String?
    let city: String?
}

struct FixtureStatus: Codable{
    let long: String?
}

struct FixtureLeague: Codable{
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let season: Int?
    let round: String?
}

struct FixtureTeams: Codable{
    let home: FixtureTeam?
    let away: FixtureTeam?
}

struct FixtureTeam: Codable{
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?
}

struct FixtureGoals: Codable{
    let home: Int?
    let away: Int?
}
