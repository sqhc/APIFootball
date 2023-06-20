//
//  TeamsBySeansonLeaueView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/20/23.
//

import SwiftUI

struct TeamsBySeansonLeaueView: View {
    @StateObject var vm: TeamsBySeansonLeaueViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let teams = vm.teams?.response{
                List(teams, id:\.team?.id){ team in
                    LeagueTeamItem(team: team)
                }
                .listStyle(.plain)
                .navigationTitle("Teams in the league")
            } else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else{ return }
            showed.toggle()
            vm.fetchTeams()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cacncel") {
                
            }
        }
    }
}

struct TeamsBySeansonLeaueView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsBySeansonLeaueView(vm: TeamsBySeansonLeaueViewModel(league: "", season: ""))
    }
}

struct LeagueTeamItem: View{
    var team: Team
    var body: some View{
        VStack{
            if let teamInfo = team.team{
                LeagueTeamInfoConten(teamInfo: teamInfo)
            }
            
            if let venueInfo = team.venue{
                LeagueTeamVenueInfoContent(venueInfo: venueInfo)
            }
        }
    }
}

struct LeagueTeamInfoConten: View{
    var teamInfo: TeamInfo
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: teamInfo.logo ?? ""))
            Text("Team name: \(teamInfo.name ?? "") Team code: \(teamInfo.code ?? "")")
            Text("Country: \(teamInfo.country ?? "")")
            Text("Founded in \(teamInfo.founded ?? 0)")
            if let national = teamInfo.national{
                Text(national ? "Is national team" : "Not national team")
            }
            NavigationLink("Coaches in the team") {
                CoachesByTeamView(vm: CoachesByTeamViewModel(teamName: teamInfo.name ?? "", teamID: "\(teamInfo.id ?? 0)"))
            }
        }
    }
}

struct LeagueTeamVenueInfoContent: View{
    var venueInfo: VenueInfo
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: venueInfo.image ?? ""))
            Text("Venue name: \(venueInfo.name ?? "")")
            Text("City: \(venueInfo.city ?? "")")
            Text("Address: \(venueInfo.address ?? "")")
            Text("Venue capacity: \(venueInfo.capacity ?? 0)")
            Text("Surface: \(venueInfo.surface ?? "")")
        }
    }
}
