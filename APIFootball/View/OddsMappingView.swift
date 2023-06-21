//
//  OddsMappingView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import SwiftUI

struct OddsMappingView: View {
    @StateObject var vm: OddsMappingViewModel
    
    var body: some View {
        ZStack{
            if let odds = vm.odds?.response{
                List(odds, id:\.fixture?.id){ odd in
                    VStack{
                        Text("Fixture id: \(odd.fixture?.id ?? 0)")
                        Text("Fixture date: \(odd.fixture?.date ?? "")")
                        Text("Updated at: \(odd.update ?? "")")
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Odds")
            } else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchOdds()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct OddsMappingView_Previews: PreviewProvider {
    static var previews: some View {
        OddsMappingView(vm: OddsMappingViewModel())
    }
}
