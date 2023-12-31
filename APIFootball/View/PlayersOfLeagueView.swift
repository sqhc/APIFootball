//
//  PlayersOfLeagueView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/18/23.
//

import SwiftUI

struct PlayersOfLeagueView: View {
    @StateObject var vm: PlayersOfLeagueViewModel
    @State var showed = false
    var body: some View {
        ZStack{
            if let players = vm.players?.response{
                List(players, id:\.player?.id){ player in
                    LeaguePlayerItem(player: player)
                }
                .listStyle(.plain)
                .navigationTitle("Players from this league")
            } else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchPlayers()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
            }
        }
        .environmentObject(vm)
    }
}

struct PlayersOfLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersOfLeagueView(vm: PlayersOfLeagueViewModel(league: "", season: ""))
    }
}

struct LeaguePlayerItem: View{
    @EnvironmentObject var vm: PlayersOfLeagueViewModel
    var player: Player
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: player.player?.photo ?? ""))
            Text(player.player?.name ?? "")
            Text("\(player.player?.firstname ?? ""). \(player.player?.lastname ?? "")")
            Text("Birth date: \(player.player?.birth?.date ?? "") Birth place: \(player.player?.birth?.place ?? "") Birth country \(player.player?.birth?.country ?? "")")
            Text("Nationality: \(player.player?.nationality ?? "") Height: \(player.player?.height ?? "") Weight: \(player.player?.weight ?? "")")
            NavigationLink("Player statistics") {
                PlayerStatisticsByPlayerIDView(vm: PlayerStatisticsByPlayerIDViewModel(id: "\(player.player?.id ?? 0)", name: player.player?.name ?? "", season: vm.season))
            }
        }
    }
}
