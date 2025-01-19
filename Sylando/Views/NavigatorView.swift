//
//  NavigatorView.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import SwiftUI

struct NavigatorView: View {
    @StateObject private var cartViewModel = CartViewModel()

    var body: some View {
        TabView {
            ShirtListView()
                .tabItem {
                    Label("Shirts", systemImage: "tshirt")
                }
                .environmentObject(cartViewModel)
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .environmentObject(cartViewModel)
        }
        .accentColor(.blue)
    }
}

#Preview {
    NavigatorView()
}
