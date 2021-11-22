//
//  ContentView.swift
//  iDine
//
//  Created by Andrew Kuttichira on 11/22/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewInterfaceOrientation(.portrait)
    }
}
