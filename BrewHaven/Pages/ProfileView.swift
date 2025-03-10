//
//  ProfileView.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

struct ProfileView: View {
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile header
                    HStack(spacing: 20) {
                        Image("profile-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Alex Johnson")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("alex.johnson@example.com")
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Rewards card
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color("PrimaryBrown"), Color("SecondaryBrown")]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .cornerRadius(15)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Brew Haven Rewards")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("350 points")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Progress bar
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 10)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .frame(width: 250, height: 10)
                            }
                            
                            Text("150 more points until free drink")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Account section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Account")
                            .font(.title3)
                            .foregroundColor(Color("PrimaryBrown"))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            ProfileMenuRow(icon: "lock.fill", title: "Personal Information")
                            ProfileMenuRow(icon: "creditcard.fill", title: "Payment Methods")
                            ProfileMenuRow(icon: "mappin.and.ellipse", title: "Addresses")
                            ProfileMenuRow(icon: "doc.text.fill", title: "Order History")
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                    
                    // Preferences section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Preferences")
                            .font(.title3)
                            .foregroundColor(Color("PrimaryBrown"))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            ProfileMenuRow(icon: "bell.fill", title: "Notifications")
                            ProfileMenuRow(icon: "cup.and.saucer.fill", title: "Favorite Drinks")
                            
                            // Dark mode toggle
                            HStack {
                                Label {
                                    Text("Dark Mode")
                                } icon: {
                                    Image(systemName: "moon.fill")
                                        .foregroundColor(Color("PrimaryBrown"))
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $isDarkMode)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct ProfileMenuRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Label {
                Text(title)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(Color("PrimaryBrown"))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .overlay(
            Divider()
                .background(Color.gray.opacity(0.2))
                .padding(.leading),
            alignment: .bottom
        )
    }
}

//
//  ProductDetailView.swift
//  BrewHaven
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var quantity = 1
    @State private var selectedSize = "Grande"
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    let sizes = ["Tall", "Grande", "Venti"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Product image
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(15)
                
                // Product title and description
                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(product.description)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Size selection
                Text("Size")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryBrown"))
                
                HStack {
                    ForEach(sizes, id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text(size)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(selectedSize == size ? Color("PrimaryBrown") : Color.white)
                                .foregroundColor(selectedSize == size ? .white : .black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: selectedSize == size ? 0 : 1)
                                )
                        }
                    }
                }
                
                // Customizations
                Text("Customizations")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryBrown"))
                
                CustomizationRow(title: "Milk", value: "Whole Milk")
                CustomizationRow(title: "Espresso Shots", value: "2 Shots")
                CustomizationRow(title: "Caramel Drizzle", value: "Regular")
                CustomizationRow(title: "Whipped Cream", value: "No")
                
                Spacer(minLength: 30)
                
                // Add to cart action
                HStack {
                    // Quantity control
                    HStack {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Text("-")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        Text("\(quantity)")
                            .font(.headline)
                            .frame(width: 40)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Text("+")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(30)
                    
                    // Add to cart button
                    Button(action: {
                        let customizedProduct = product
                        let options = "\(selectedSize), Whole Milk"
                        cartManager.addToCart(customizedProduct, quantity: quantity, options: options)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add to Cart - $\(product.price * Double(quantity), specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryBrown"))
                            .cornerRadius(30)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button(action: {
                // Add to favorites
            }) {
                Image(systemName: "heart")
                    .foregroundColor(Color("PrimaryBrown"))
            }
        )
    }
}

struct CustomizationRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 12)
        .overlay(
            Divider()
                .background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}

