//
//  SearchCountriesView.swift
//  APIFootball
//
//  Created by 沈清昊 on 6/14/23.
//

import SwiftUI

struct SearchCountriesView: View {
    @State var name = ""
    @State var code = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Country Name", text: $name)
                    .frame(width: 400, height: 50)
                    .background(Color.mint.opacity(0.3).cornerRadius(20))
                TextField("Country Code", text: $code)
                    .frame(width: 400, height: 50)
                    .background(Color.indigo.opacity(0.3).cornerRadius(20))
                NavigationLink {
                    CountriesView(vm: CountriesViewModel(name: name, code: code))
                } label: {
                    Image(systemName: "magnifyingglass.circle")
                }

            }
            .navigationTitle("Search for countries")
        }
    }
}

struct SearchCountriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCountriesView()
    }
}
