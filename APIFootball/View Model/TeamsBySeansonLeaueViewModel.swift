//
//  TeamsBySeansonLeaueViewModel.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/20/23.
//

import Foundation
import Combine

class TeamsBySeansonLeaueViewModel: ObservableObject{
    let leagueID : String
    let season: String
    
    var searchTeamsByLeagueSeasonStr = "https://api-football-v1.p.rapidapi.com/v3/teams?league="
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
    ]
    
    @Published var teams: Teams?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(league: String, season: String){
        self.leagueID = league
        self.season = season
    }
    
    func fetchTeams(){
        searchTeamsByLeagueSeasonStr += "\(leagueID)&season=\(season)"
        
        guard let url = URL(string: searchTeamsByLeagueSeasonStr) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Teams in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                guard let teams = try? JSONDecoder().decode(Teams.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return teams
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] teams in
                self?.teams = teams
            }
            .store(in: &bag)
    }
}
extension TeamsBySeansonLeaueViewModel{
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
