//
//  TimezonesView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/14/23.
//

import SwiftUI

struct TimezonesView: View {
    @StateObject var vm: TimezonesViewModel
    
    var body: some View {
        ZStack{
            if let timezones = vm.timezones?.response{
                List(timezones, id:\.self){ timezone in
                    Text(timezone)
                }
                .navigationTitle("Timezones")
                .listStyle(.plain)
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchTimezones()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct TimezonesView_Previews: PreviewProvider {
    static var previews: some View {
        TimezonesView(vm: TimezonesViewModel())
    }
}
