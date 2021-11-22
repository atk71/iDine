//
//  iDineApp.swift
//  iDine
//
//  Created by Andrew Kuttichira on 11/22/21.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
