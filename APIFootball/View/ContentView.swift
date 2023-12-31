//
//  ContentView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(colors: [Color.orange, Color.yellow], center: .top, startRadius: 10, endRadius: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack{
                    NavigationLink("Timezones") {
                        TimezonesView(vm: TimezonesViewModel())
                    }
                    NavigationLink("Search countries"){
                        SearchCountriesView()
                    }
                    NavigationLink("Seasons") {
                        SeasonsView(vm: SeasonsViewModel())
                    }
                    NavigationLink("Odds") {
                        OddsMappingView(vm: OddsMappingViewModel())
                    }
                }
                .navigationTitle("Welcome")
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
