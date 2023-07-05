//
//  ContentView.swift
//  Catalog-iOS
//
//  Created by Andi Septiadi on 05/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var controller: ListController
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(controller: Injection().provideListController())
    }
}
