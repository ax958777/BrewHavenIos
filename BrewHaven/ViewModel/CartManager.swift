//
//  CartManager.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//
import SwiftUI

class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + $1.totalPrice }
    }
    
    var tax: Double {
        subtotal * 0.09
    }
    
    let deliveryFee: Double = 1.99
    
    var total: Double {
        subtotal + tax + deliveryFee
    }
    
    func addToCart(_ product: Product, quantity: Int = 1, options: String = "Standard") {
        // Check if product already exists with same options
        if let index = cartItems.firstIndex(where: {
            $0.product.id == product.id && $0.options == options
        }) {
            cartItems[index].quantity += quantity
        } else {
            let newItem = CartItem(
                product: product,
                quantity: quantity,
                options: options
            )
            cartItems.append(newItem)
        }
    }
    
    func removeFromCart(_ item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }
    
    func increaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].quantity += 1
        }
    }
    
    func decreaseQuantity(for item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                removeFromCart(item)
            }
        }
    }
}
