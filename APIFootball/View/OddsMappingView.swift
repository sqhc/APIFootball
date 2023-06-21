//
//  OddsMappingView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import SwiftUI

struct OddsMappingView: View {
    @StateObject var vm: OddsMappingViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            List(vm.odds, id:\.fixture?.id){ odd in
                VStack{
                    Text("Fixture id: \(odd.fixture?.id ?? 0)")
                    Text("Fixture date: \(odd.fixture?.date ?? "")")
                    Text("Updated at: \(odd.update ?? "")")
                    NavigationLink("Fixture events") {
                        FixtureEventsView(vm: FixtureEventsViewModel(id: "\(odd.fixture?.id ?? 0)"))
                    }
                }
                .onAppear {
                    vm.pagination(odd: odd)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Odds")
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
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
