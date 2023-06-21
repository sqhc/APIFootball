//
//  TrophiesDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import Foundation

struct Trophies: Codable{
    let response: [Trophy]?
}

struct Trophy: Codable{
    let league: String?
    let country: String?
    let season: String?
    let place: String?
}
