//
//  SeasonsView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/15/23.
//

import SwiftUI

struct SeasonsView: View {
    @StateObject var vm: SeasonsViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let seasons = vm.seasons?.response{
                List(seasons, id:\.self){ season in
                    Text("\(season)")
                    NavigationLink("Leagues in this season") {
                        LeaguesBySeasonView(vm: LeaguesBySeasonViewModel(season: "\(season)"))
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Seasons")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchSeasons()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cacnel") {
                
            }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView(vm: SeasonsViewModel())
    }
}
