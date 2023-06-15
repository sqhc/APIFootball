//
//  LeaguesBySeasonView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/15/23.
//

import SwiftUI

struct LeaguesBySeasonView: View {
    @StateObject var vm: LeaguesBySeasonViewModel
    
    var body: some View {
        ZStack{
            if let leagues = vm.leagues?.response{
                List(leagues, id:\.league?.id){ league in
                    LeagueItemBySeason(league: league)
                }
                .listStyle(.plain)
                .navigationTitle("Leagues in season: \(vm.season)")
            } else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchLeaguesBySeason()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
            }
        }
    }
}

struct LeaguesBySeasonView_Previews: PreviewProvider {
    static var previews: some View {
        LeaguesBySeasonView(vm: LeaguesBySeasonViewModel(season: ""))
    }
}

struct LeagueItemBySeason: View{
    var league: League
    var body: some View{
        VStack(alignment: .leading){
            Text("League name: \(league.league?.name ?? "")")
            Text("League type: \(league.league?.type ?? "")")
            AsyncImage(url: URL(string: league.league?.logo ?? ""))
            Text("Country name: \(league.country?.name ?? "")")
            AsyncImage(url: URL(string: league.country?.flag ?? ""))
            if let seasons = league.seasons{
                Section {
                    List(seasons, id:\.year){ season in
                        Text("Year: \(season.year ?? 0)")
                        Text("Start: \(season.start ?? "") End: \(season.end ?? "")")
                    }
                    .frame(width: 400, height: 100)
                } header: {
                    Text("Seasons")
                }
            }
        }
    }
}
