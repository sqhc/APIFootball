//
//  CountriesDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/14/23.
//

import Foundation

struct Countries: Codable{
    let response: [CountryInfo]?
}

struct CountryInfo: Codable{
    let name: String?
    let code: String?
    let flag: String?
}
