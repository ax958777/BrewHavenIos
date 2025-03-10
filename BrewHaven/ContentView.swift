//
//  ContentView.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "cup.and.saucer.fill")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(Color("PrimaryBrown"))
    }
}
