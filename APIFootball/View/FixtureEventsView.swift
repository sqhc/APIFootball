//
//  FixtureEventsView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/21/23.
//

import SwiftUI

struct FixtureEventsView: View {
    @ObservedObject var vm: FixtureEventsViewModel
    
    var body: some View {
        ZStack{
            if let events = vm.events?.response{
                List(events, id:\.player?.id){ event in
                    FixtureEventContent(event: event)
                }
                .listStyle(.plain)
                .navigationTitle("Fixture events")
            } else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchEvents)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct FixtureEventsView_Previews: PreviewProvider {
    static var previews: some View {
        FixtureEventsView(vm: FixtureEventsViewModel(id: ""))
    }
}

struct FixtureEventContent: View{
    var event: FixtureEvent
    var body: some View{
        VStack{
            Text("Event type: \(event.type ?? "")")
            Text("Detail: \(event.detail ?? "")")
            Text("Elasped time: \(event.time?.elapsed ?? 0)")
            Text("Player name: \(event.player?.name ?? "")")
            Text("Belongs to name: \(event.team?.name ?? "")")
            AsyncImage(url: URL(string: event.team?.logo ?? ""))
        }
    }
}
