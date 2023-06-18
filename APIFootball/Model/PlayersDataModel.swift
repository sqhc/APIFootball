//
//  PlayersDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/18/23.
//

import Foundation

struct Players: Codable{
    let response: [Player]?
}

struct Player: Codable{
    let player: PlayerInfo?
}

struct PlayerInfo: Codable{
    let id: Int?
    let name: String?
    let firstname: String?
    let lastname: String?
    let age: Int?
    let birth: PlayerBirth?
    let nationality: String?
    let height: String?
    let weight: String?
    let photo: String?
}

struct PlayerBirth: Codable{
    let date: String?
    let place: String?
    let country: String?
}
