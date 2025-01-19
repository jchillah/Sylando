//
//  ShirtListRowView.swift
//  Sylando
//
//  Created by Michael Winkler on 16.01.25.
//

import SwiftUI

struct ShirtListRowView: View {
    @ObservedObject var shirtsViewModel: ShirtsViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    let shirt: Shirt
    let addToCart: () -> Void

    var body: some View {
        HStack {
            Text(shirt.title)
            Text(shirt.size.uppercased())
            Spacer()
            Text(shirt.price.formatted(.currency(code: "EUR")))
        }
        .padding()
        .swipeActions {
            Button {
                shirtsViewModel.deleteShirt(shirt)
            } label: {
                Label("Löschen", systemImage: "trash")
            }
            .tint(.red)
            
            Button(action: addToCart) {
                Label("Zum Warenkorb", systemImage: "cart")
            }
            .tint(.green)
        }
    }
}

#Preview {
    ShirtListRowView(
        shirtsViewModel: ShirtsViewModel(), shirt: Shirt(title: "Test Shirt", price: 19.99, size: "M"),
        addToCart: { }
    )
}

