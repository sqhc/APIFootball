//
//  LeagueSearchOption.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/16/23.
//

import SwiftUI

struct LeagueSearchOption: View {
    let leageID: String
    let season: String
    
    
    var body: some View {
        ZStack{
            VStack{
                Text("What do you want to search for this league?")
                    .font(.largeTitle)
                Spacer()
                HStack{
                    NavigationLink {
                        FixturesOfLeagueView(vm: FixturesOfLeagueViewModel(league: leageID, season: season))
                    } label: {
                        Text("Fixtures")
                            .background(Color.green.cornerRadius(20))
                            .foregroundColor(.white)
                    }

                    NavigationLink {
                        PlayersOfLeagueView(vm: PlayersOfLeagueViewModel(league: leageID, season: season))
                    } label: {
                        Text("Players")
                            .background(Color.red.cornerRadius(20))
                            .foregroundColor(.white)
                    }

                    NavigationLink {
                        TeamsBySeansonLeaueView(vm: TeamsBySeansonLeaueViewModel(league: leageID, season: season))
                    } label: {
                        Text("Teams")
                            .background(Color.yellow.cornerRadius(20))
                            .foregroundColor(.white)
                    }

                }
                Spacer()
            }
            .navigationTitle("Search option of this league")
        }
    }
}

struct LeagueSearchOption_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSearchOption(leageID: "", season: "")
    }
}
