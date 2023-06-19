//
//  FixturePredictionsView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/19/23.
//

import SwiftUI

struct FixturePredictionsView: View {
    @ObservedObject var vm: FixturePredictionsViewModel
    
    var body: some View {
        ZStack{
            if let predicts = vm.predictions?.response{
                List(predicts, id:\.predictions?.winner?.id){ predict in
                    PredictionItem(prediction: predict)
                }
                .listStyle(.plain)
                .navigationTitle("Fixture predictions")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchPredictions)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cacnel") {
                
            }
        }
    }
}

struct FixturePredictionsView_Previews: PreviewProvider {
    static var previews: some View {
        FixturePredictionsView(vm: FixturePredictionsViewModel(fixture: ""))
    }
}

struct PredictionItem: View{
    var prediction: Prediction
    var body: some View{
        VStack{
            Text("Predict winner: \(prediction.predictions?.winner?.name ?? "")")
            Text("Comment: \(prediction.predictions?.winner?.comment ?? "")")
            if let win_draw = prediction.predictions?.win_or_draw{
                Text("Win or draw? \(win_draw ? "Yes" : "No")")
            }
            Text("Under over: \(prediction.predictions?.under_over ?? "")")
            Text("Goals Home: \(prediction.predictions?.goals?.home ?? "") Away: \(prediction.predictions?.goals?.away ?? "")")
            Text("Advice: \(prediction.predictions?.advice ?? "")")
            Text("Percents of Home: \(prediction.predictions?.percent?.home ?? "") Draw: \(prediction.predictions?.percent?.draw ?? "") Away: \(prediction.predictions?.percent?.away ?? "")")
        }
    }
}
