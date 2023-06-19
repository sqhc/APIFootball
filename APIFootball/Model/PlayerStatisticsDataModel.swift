//
//  PlayerStatisticsDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/19/23.
//

import Foundation

struct Statistics: Codable{
    let response: [Statistic]?
}

struct Statistic: Codable{
    let statistics: [SatisticContainer]?
}

struct SatisticContainer: Codable{
    let team: SatisticTeam?
    let league: StatisticLeague?
    let games: StatisticGames?
    let shots: StatisticShots?
    let goals: StatisticGoals?
    let cards: StatisticCards?
}

struct SatisticTeam: Codable{
    let id: Int?
    let name: String?
    let logo: String?
}

struct StatisticLeague: Codable{
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let season: Int?
}

struct StatisticGames: Codable{
    let appearences: Int?
    let lineups: Int?
    let minutes: Int?
    let position: String?
    let rating: String?
    let captain: Bool?
}

struct StatisticShots: Codable{
    let total: Int?
    let on: Int?
}

struct StatisticGoals: Codable{
    let total: Int?
    let conceded: Int?
    let assists: Int?
}

struct StatisticCards: Codable{
    let yellow: Int?
    let yellowred: Int?
    let red: Int?
}
