//
//  LeaguesDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/15/23.
//

import Foundation

struct Leagues: Codable{
    let response: [League]?
}

struct League: Codable{
    let league: LeageInfo?
    let country: CountryInfo?
    let seasons: [seasonInfo]?
}

struct LeageInfo: Codable{
    let id: Int?
    let name: String?
    let type: String?
    let logo: String?
}

struct seasonInfo: Codable{
    let year: Int?
    let start: String?
    let end: String?
}
