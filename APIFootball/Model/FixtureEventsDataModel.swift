//
//  FixtureEventsDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import Foundation

struct FixtureEvents: Codable{
    let response: [FixtureEvent]?
}

struct FixtureEvent: Codable{
    let time: FixtureEventTime?
    let team: FixtureTeam?
    let player: FixtureEventPlayer?
    let type: String?
    let detail: String?
}

struct FixtureEventTime: Codable{
    let elapsed: Int?
}

struct FixtureEventPlayer: Codable{
    let id: Int?
    let name: String?
}
