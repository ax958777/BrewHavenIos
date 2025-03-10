//
//  BrewHavenApp.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

@main
struct BrewHavenApp: App {
    @StateObject private var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager)
        }
    }
}
