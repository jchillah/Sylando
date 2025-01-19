//
//  CartViewModel.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [Shirt] = []

    func addToCart(_ shirt: Shirt) {
        cartItems.append(shirt)
    }

    
    func clearCart() {
        cartItems.removeAll()
    }
    
    func removeFromCart(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
}
