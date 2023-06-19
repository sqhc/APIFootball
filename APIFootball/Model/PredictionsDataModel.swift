//
//  PredictionsDataModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/19/23.
//

import Foundation

struct Predictions: Codable{
    let response: [Prediction]?
}

struct Prediction: Codable{
    let predictions: PredictionInfo?
}

struct PredictionInfo: Codable{
    let winner: PredictWinner?
    let win_or_draw: Bool?
    let under_over: String?
    let goals: PredictGoals?
    let advice: String?
    let percent: PredictPercent?
}

struct PredictWinner: Codable{
    let id: Int?
    let name: String?
    let comment: String?
}

struct PredictGoals: Codable{
    let home: String?
    let away: String?
}

struct PredictPercent: Codable{
    let home: String?
    let draw: String?
    let away: String?
}
