//
//  PlayerStatisticsByPlayerIDViewModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/19/23.
//

import Foundation
import Combine

class PlayerStatisticsByPlayerIDViewModel: ObservableObject{
    let playerId : String
    let season: String
    let playerName: String
    
    var searchStatisticsByIDStr = "https://api-football-v1.p.rapidapi.com/v3/players?id="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
    ]
    
    @Published var statistics: Statistics?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: String, name: String, season: String){
        self.season = season
        self.playerId = id
        self.playerName = name
    }
    
    func fetchStatistics(){
        searchStatisticsByIDStr += "\(playerId)&season=\(season)"
        
        guard let url = URL(string: searchStatisticsByIDStr) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Statistics in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                guard let statistics = try? JSONDecoder().decode(Statistics.self, from: result.data) else {
                    throw LoadError.failedToDecode
                }
                return statistics
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] statistics in
                self?.statistics = statistics
            }
            .store(in: &bag)
    }
}
extension PlayerStatisticsByPlayerIDViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case failedToUnwrapOptional
        case invalidStatusCode
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Unable to decode the data."
            case .failedToUnwrapOptional:
                return "Can not unwrap optional value"
            case .invalidStatusCode:
                return "Request failed due to invalid status code."
            }
        }
    }
}
