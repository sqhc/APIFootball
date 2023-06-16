//
//  LeaguesBySeasonView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/15/23.
//

import SwiftUI

struct LeaguesBySeasonView: View {
    @StateObject var vm: LeaguesBySeasonViewModel
    @State var showed = false
    
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
            guard !showed else { return }
            showed.toggle()
            vm.fetchLeaguesBySeason()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
            }
        }
        .environmentObject(vm)
    }
}

struct LeaguesBySeasonView_Previews: PreviewProvider {
    static var previews: some View {
        LeaguesBySeasonView(vm: LeaguesBySeasonViewModel(season: ""))
    }
}

struct LeagueItemBySeason: View{
    @EnvironmentObject var vm: LeaguesBySeasonViewModel
    var league: League
    var body: some View{
        VStack(alignment: .leading){
            Text("League name: \(league.league?.name ?? "")")
            Text("League type: \(league.league?.type ?? "")")
            AsyncImage(url: URL(string: league.league?.logo ?? ""))
            Text("Country name: \(league.country?.name ?? "")")
            AsyncImage(url: URL(string: league.country?.flag ?? ""))
            NavigationLink("Search options") {
                LeagueSearchOption(leageID: "\(league.league?.id ?? 0)", season: vm.season)
            }
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
