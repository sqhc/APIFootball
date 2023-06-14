//
//  CountriesView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/14/23.
//

import SwiftUI

struct CountriesView: View {
    @State var vm: CountriesViewModel
    
    var body: some View {
        ZStack{
            if let countries = vm.countries?.response{
                List(countries, id:\.name){ country in
                    CountryItem(country: country)
                }
                .listStyle(.plain)
                .navigationTitle("Countries")
            }else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchCountries()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Cancel") {
                
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView(vm: CountriesViewModel())
    }
}

struct CountryItem: View{
    var country: CountryInfo
    var body: some View{
        VStack(alignment: .leading){
            Text(country.name ?? "")
            Text(country.code ?? "")
            AsyncImage(url: URL(string: country.flag ?? ""))
        }
    }
}
