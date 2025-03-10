//
//  Model.swift
//  BrewHaven
//
//  Created by AlexX on 2025-03-10.
//

import Foundation
import SwiftUI

// Product Model
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let price: Double
    let category: String
}

// Cart Item Model
struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
    let options: String
    
    var totalPrice: Double {
        return product.price * Double(quantity)
    }
}

// Sample Data
let featuredProducts = [
    Product(
        name: "Caramel Macchiato",
        image: "caramel-macchiato",
        description: "Freshly steamed milk with vanilla-flavored syrup, marked with espresso",
        price: 4.50,
        category: "Coffee"
    ),
    Product(
        name: "Mocha Frappuccino",
        image: "mocha-frappe",
        description: "Coffee blended with mocha sauce and milk, topped with whipped cream",
        price: 5.25,
        category: "Cold Coffee"
    )
]

let menuProducts = [
    Product(
        name: "Espresso",
        image: "espresso",
        description: "Rich espresso with crema",
        price: 2.95,
        category: "Hot Coffee"
    ),
    Product(
        name: "Cappuccino",
        image: "cappuccino",
        description: "Espresso with steamed milk and foam",
        price: 3.75,
        category: "Hot Coffee"
    ),
    Product(
        name: "Latte",
        image: "latte",
        description: "Espresso with steamed milk",
        price: 4.25,
        category: "Hot Coffee"
    ),
    Product(
        name: "Cold Brew",
        image: "cold-brew",
        description: "Slow-steeped for 20 hours",
        price: 4.50,
        category: "Cold Coffee"
    ),
    Product(
        name: "Croissant",
        image: "croissant",
        description: "Buttery, flaky pastry",
        price: 3.25,
        category: "Pastries"
    ),
    Product(
        name: "Blueberry Muffin",
        image: "muffin",
        description: "Fresh blueberries baked in a light muffin",
        price: 3.50,
        category: "Pastries"
    )
]
