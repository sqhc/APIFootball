//
//  SeasonsView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/15/23.
//

import SwiftUI

struct SeasonsView: View {
    @StateObject var vm: SeasonsViewModel
    var body: some View {
        ZStack{
            if let seasons = vm.seasons?.response{
                List(seasons, id:\.self){ season in
                    Text("\(season)")
                }
                .listStyle(.plain)
                .navigationTitle("Seasons")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
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
