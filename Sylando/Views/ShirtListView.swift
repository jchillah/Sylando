//
//  ShirtListView.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import SwiftUI

struct ShirtListView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @StateObject private var shirtsViewModel = ShirtsViewModel()

    @State private var isAddShirtPresented: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(shirtsViewModel.shirts) { shirt in
                    ShirtListRowView(
                        shirtsViewModel: shirtsViewModel,
                        shirt: shirt,
                        addToCart: {
                            cartViewModel.addToCart(shirt)
                        }
                    )
                }
            }
            .navigationTitle("T-Shirts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddShirtPresented.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddShirtPresented) {
                ShirtAddView(isPresented: $isAddShirtPresented)
                    .environmentObject(shirtsViewModel)
            }
        }
    }
}

#Preview {
    ShirtListView()
        .environmentObject(CartViewModel())
}
