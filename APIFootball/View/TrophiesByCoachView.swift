//
//  TrophiesByCoachView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import SwiftUI

struct TrophiesByCoachView: View {
    @ObservedObject var vm: TrophiesByCoachViewModel
    
    var body: some View {
        ZStack{
            if let trophies = vm.trophies?.response{
                List(trophies, id:\.season){ trophy in
                    Text("League name: \(trophy.league ?? "")")
                    Text("Country: \(trophy.country ?? "")")
                    Text("Season: \(trophy.season ?? "")")
                    Text("Place: \(trophy.place ?? "")")
                }
                .listStyle(.plain)
                .navigationTitle("\(vm.coachName)'s trophies")
            } else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchTrophies)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct TrophiesByCoachView_Previews: PreviewProvider {
    static var previews: some View {
        TrophiesByCoachView(vm: TrophiesByCoachViewModel(coachID: ""))
    }
}
