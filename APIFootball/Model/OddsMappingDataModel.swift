//
//  OddsMappingDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import Foundation

struct OddMappings: Codable{
    let response: [OddMapping]?
}

struct OddMapping: Codable{
    let fixture: OddFixture?
    let update: String?
}

struct OddFixture: Codable{
    let id: Int?
    let date: String?
}
