//
//  FixturesOfLeagueView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/16/23.
//

import SwiftUI

struct FixturesOfLeagueView: View {
    @StateObject var vm: FixturesOfLeagueViewModel
    
    var body: some View {
        ZStack{
            if let fixtures = vm.fixtures?.response{
                List(fixtures, id:\.fixture?.id){ fixture in
                    FixtureContent(fixture: fixture)
                }
                .listStyle(.plain)
                .navigationTitle("Fixtures in league")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchFixturesByLeague()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct FixturesOfLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesOfLeagueView(vm: FixturesOfLeagueViewModel(league: "", season: ""))
    }
}

struct FixtureContent: View{
    var fixture: Fixture
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                if let fixtureInfo = fixture.fixture{
                    FixtureInfoContent(fixtureInfo: fixtureInfo)
                }
                
                if let fixtureLeague = fixture.league{
                    FixtureLeagueContent(fixtureLeague: fixtureLeague)
                }
            }
            
            HStack{
                if let homeTeam = fixture.teams?.home{
                    FixtureTeamContent(teamPos: "Home", fixtureTeam: homeTeam)
                }
                
                if let awayTeam = fixture.teams?.away{
                    FixtureTeamContent(teamPos: "Away", fixtureTeam: awayTeam)
                }
            }
            
            Text("Home goals: \(fixture.goals?.home ?? 0) Away goals: \(fixture.goals?.away ?? 0)")
        }
    }
}

struct FixtureInfoContent: View{
    var fixtureInfo: FixtureInfo
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Refreee: \(fixtureInfo.referee ?? "")")
            Text("Timezone: \(fixtureInfo.timezone ?? "")")
            Text("Date: \(fixtureInfo.date ?? "")")
            Text("Venue name: \(fixtureInfo.venue?.name ?? "") Venue city: \(fixtureInfo.venue?.city ?? "")")
            Text("Fixture status: \(fixtureInfo.status?.long ?? "")")
        }
    }
}

struct FixtureLeagueContent: View{
    var fixtureLeague: FixtureLeague
    
    var body: some View{
        VStack(alignment: .leading){
            Text("League name: \(fixtureLeague.name ?? "")")
            Text("League country: \(fixtureLeague.country ?? "")")
            Text("League season: \(fixtureLeague.season ?? 0)")
            Text("League round: \(fixtureLeague.round ?? "")")
            AsyncImage(url: URL(string: fixtureLeague.logo ?? ""))
        }
    }
}

struct FixtureTeamContent: View{
    var teamPos: String
    var fixtureTeam: FixtureTeam
    
    var body: some View{
        VStack{
            Text("\(teamPos) team")
            AsyncImage(url: URL(string: fixtureTeam.logo ?? ""))
            Text("\(fixtureTeam.name ?? "")")
            if let win = fixtureTeam.winner{
                if win{
                    Text("Winner!")
                }
            }
        }
    }
}
