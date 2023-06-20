//
//  CoachesDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/20/23.
//

import Foundation

struct Coaches: Codable{
    let response: [Coach]?
}

struct Coach: Codable{
    let id: Int?
    let name: String?
    let firstname: String?
    let lastname: String?
    let age: Int?
    let birth: CoachBirth?
    let nationality: String?
    let photo: String?
    let career: [CoachCareer]?
}

struct CoachBirth: Codable{
    let date: String?
    let place: String?
    let country: String?
}

struct CoachCareer: Codable{
    let team: CoachTeam?
    let start: String?
    let end: String?
}

struct CoachTeam: Codable{
    let id: Int?
    let name: String?
    let logo: String?
}

