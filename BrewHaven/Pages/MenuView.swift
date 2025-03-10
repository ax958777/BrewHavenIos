//
//  MenuView.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

struct MenuView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    let categories = ["All", "Hot Coffee", "Cold Coffee", "Tea", "Pastries"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search menu...", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    
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
                    }
                    
                    // Menu grid
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(menuProducts) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                MenuItemCard(product: product)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.bottom, 80)
                }
                .padding()
            }
            .navigationTitle("Menu")
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct MenuItemCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            // Product image
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .cornerRadius(15, corners: [.topLeft, .topRight])
            
            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.system(size: 14, weight: .bold))
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color("PrimaryBrown"))
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}


