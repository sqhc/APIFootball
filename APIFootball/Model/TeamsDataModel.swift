//
//  TeamsDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/20/23.
//

import Foundation

struct Teams: Codable{
    let response: [Team]?
}

struct Team: Codable{
    let team: TeamInfo?
    let venue: VenueInfo?
}

struct TeamInfo: Codable{
    let id: Int?
    let name: String?
    let code: String?
    let country: String?
    let founded: Int?
    let national: Bool?
    let logo: String?
}

struct VenueInfo: Codable{
    let id: Int?
    let name: String?
    let address: String?
    let city: String?
    let capacity: Int?
    let surface: String?
    let image: String?
}
