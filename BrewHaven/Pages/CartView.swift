//
//  CartView.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                if cartManager.cartItems.isEmpty {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "cart")
                            .font(.system(size: 70))
                            .foregroundColor(.gray)
                        Text("Your cart is empty")
                            .font(.title2)
                        Text("Add some delicious coffee to get started")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .frame(minHeight: 500)
                    .padding()
                } else {
                    VStack(spacing: 0) {
                        // Cart items
                        ForEach(cartManager.cartItems) { item in
                            CartItemRow(cartItem: item)
                                .environmentObject(cartManager)
                        }
                        
                        // Order summary
                        VStack(spacing: 10) {
                            HStack {
                                Text("Subtotal")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$\(cartManager.subtotal, specifier: "%.2f")")
                            }
                            
                            HStack {
                                Text("Tax")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$\(cartManager.tax, specifier: "%.2f")")
                            }
                            
                            HStack {
                                Text("Delivery Fee")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$\(cartManager.deliveryFee, specifier: "%.2f")")
                            }
                            
                            Divider()
                                .padding(.vertical, 5)
                            
                            HStack {
                                Text("Total")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("$\(cartManager.total, specifier: "%.2f")")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding()
                        
                        // Checkout button
                        Button(action: {
                            // Checkout action
                        }) {
                            Text("Proceed to Checkout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryBrown"))
                                .cornerRadius(30)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationTitle("My Cart")
        }
    }
}

struct CartItemRow: View {
    let cartItem: CartItem
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 15) {
            // Product image
            Image(cartItem.product.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            // Item details
            VStack(alignment: .leading, spacing: 5) {
                Text(cartItem.product.name)
                    .font(.headline)
                
                Text(cartItem.options)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Quantity control
                HStack {
                    Button(action: {
                        cartManager.decreaseQuantity(for: cartItem)
                    }) {
                        Image(systemName: "minus")
                            .padding(5)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    
                    Text("\(cartItem.quantity)")
                        .frame(width: 30, alignment: .center)
                    
                    Button(action: {
                        cartManager.increaseQuantity(for: cartItem)
                    }) {
                        Image(systemName: "plus")
                            .padding(5)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
            }
            
            Spacer()
            
            // Price
            Text("$\(cartItem.totalPrice, specifier: "%.2f")")
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryBrown"))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

