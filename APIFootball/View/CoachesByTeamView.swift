//
//  CoachesByTeamView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/20/23.
//

import SwiftUI

struct CoachesByTeamView: View {
    @StateObject var vm: CoachesByTeamViewModel
    
    var body: some View {
        ZStack{
            if let coaches = vm.coaches?.response{
                List(coaches, id:\.id){ coach in
                    CoachInfoContent(coach: coach)
                }
                .listStyle(.plain)
                .navigationTitle("\(vm.teamName)'s coaches")
            } else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchCoaches()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct CoachesByTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CoachesByTeamView(vm: CoachesByTeamViewModel(teamID: ""))
    }
}

struct CoachInfoContent: View{
    var coach: Coach
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: coach.photo ?? ""))
            Text(coach.name ?? "")
            Text("First name: \(coach.firstname ?? "") Last name: \(coach.lastname ?? "")")
            Text("Age: \(coach.age ?? 0)")
            Text("Birth date: \(coach.birth?.date ?? "") Place: \(coach.birth?.place ?? "") Country: \(coach.birth?.country ?? "")")
            Text("Nationality: \(coach.nationality ?? "")")
            if let careers = coach.career{
                Section {
                    List(careers, id:\.start){ career in
                        CoachCareerContent(career: career)
                    }
                    .frame(width: 400, height: 200)
                } header: {
                    Text("Career")
                }
            }
        }
    }
}

struct CoachCareerContent: View{
    var career: CoachCareer
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: career.team?.logo ?? ""))
            Text("Team name: \(career.team?.name ?? "")")
            Text("Start: \(career.start ?? "")")
            Text("End: \(career.end ?? "")")
        }
    }
}
