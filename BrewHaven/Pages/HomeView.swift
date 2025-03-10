//
//  HomeView.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    let categories = ["All", "Coffee", "Espresso", "Cold Brew", "Food"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header with greeting
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Good Morning, Alex")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("What coffee can we get for you today?")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        // Profile image
                        Circle()
                            .fill(Color("Accent"))
                            .frame(width: 40, height: 40)
                    }
                    .padding(.horizontal)
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search coffee, tea, food...", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedCategory == category ?
                                        Color("PrimaryBrown") : Color.white
                                    )
                                    .foregroundColor(
                                        selectedCategory == category ?
                                        Color.white : Color.black
                                    )
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: selectedCategory == category ? 0 : 1)
                                    )
                                    .onTapGesture {
                                        selectedCategory = category
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Featured Drinks
                    Text("Featured Drinks")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Featured coffee cards
                    VStack(spacing: 15) {
                        NavigationLink(destination: ProductDetailView(product: featuredProducts[0])) {
                            FeaturedCoffeeCard(product: featuredProducts[0])
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ProductDetailView(product: featuredProducts[1])) {
                            FeaturedCoffeeCard(product: featuredProducts[1])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct FeaturedCoffeeCard: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack(alignment: .leading) {
            // Coffee image
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipped()
                .cornerRadius(15, corners: [.topLeft, .topRight])
            
            // Info section
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.headline)
                
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text("$\(product.price, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryBrown"))
                    
                    Spacer()
                    
                    Button(action: {
                        cartManager.addToCart(product)
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("PrimaryBrown"))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

