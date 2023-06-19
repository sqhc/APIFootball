//
//  PlayerStatisticsByPlayerIDView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/19/23.
//

import SwiftUI

struct PlayerStatisticsByPlayerIDView: View {
    @ObservedObject var vm: PlayerStatisticsByPlayerIDViewModel
    
    var body: some View {
        ZStack{
            if let statistics = vm.statistics?.response?[0].statistics{
                List(statistics, id:\.league?.id){ statistic in
                    StatisticContent(statistic: statistic)
                }
                .listStyle(.plain)
                .navigationTitle("\(vm.playerName)'s statistics")
            } else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchStatistics)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct PlayerStatisticsByPlayerIDView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatisticsByPlayerIDView(vm: PlayerStatisticsByPlayerIDViewModel(id: "", name: "", season: ""))
    }
}

struct StatisticContent: View{
    var statistic: SatisticContainer
    var body: some View{
        VStack{
            HStack{
                if let team = statistic.team{
                    StatisticTeamItem(team: team)
                }
                
                if let league = statistic.league{
                    StatisticLeagueItem(league: league)
                }
            }
            
            HStack{
                if let games = statistic.games{
                    StatisticGamesItem(games: games)
                }
                
                if let shots = statistic.shots{
                    StatisticShotsItem(shots: shots)
                }
            }
            
            HStack{
                if let goals = statistic.goals{
                    StatisticGoalsItem(goals: goals)
                }
                
                if let cards = statistic.cards{
                    StatisticCardsItem(cards: cards)
                }
            }
        }
    }
}

struct StatisticTeamItem: View{
    var team: SatisticTeam
    var body: some View{
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: team.logo ?? ""))
            Text("Team name: \(team.name ?? "")")
        }
    }
}

struct StatisticLeagueItem: View{
    var league: StatisticLeague
    var body: some View{
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: league.logo ?? ""))
            Text("League name: \(league.name ?? "")")
            Text("League country: \(league.country ?? "")")
            Text("League season: \(league.season ?? 0)")
        }
    }
}

struct StatisticGamesItem: View{
    var games: StatisticGames
    var body: some View{
        VStack(alignment: .leading){
            Text("Appearances: \(games.appearences ?? 0)")
            Text("Lineups: \(games.lineups ?? 0)")
            Text("Minutes: \(games.minutes ?? 0)")
            Text("Position: \(games.position ?? "")")
            Text("Rate: \(games.rating ?? "")")
            if let captain = games.captain{
                Text(captain ? "Captain" : "Not captain")
            }
        }
    }
}

struct StatisticShotsItem: View{
    var shots : StatisticShots
    var body: some View{
        VStack(alignment: .leading){
            Text("Total shots: \(shots.total ?? 0)")
            Text("On shots: \(shots.on ?? 0)")
        }
    }
}

struct StatisticGoalsItem: View{
    var goals: StatisticGoals
    var body: some View{
        VStack(alignment: .leading){
            Text("Total goals: \(goals.total ?? 0)")
            Text("Conceded: \(goals.conceded ?? 0)")
            Text("Assists: \(goals.assists ?? 0)")
        }
    }
}

struct StatisticCardsItem: View{
    var cards: StatisticCards
    var body: some View{
        VStack(alignment: .leading){
            Text("Yellow cards: \(cards.yellow ?? 0)")
            Text("Yellowred cards: \(cards.yellowred ?? 0)")
            Text("Red cards: \(cards.red ?? 0)")
        }
    }
}
