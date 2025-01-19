//
//  CartView.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var isCheckoutActive: Bool = false
    
    @State private var nameFromCheckout: String = ""
    @State private var streetFromCheckout: String = ""
    @State private var cityFromCheckout: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                if cartViewModel.cartItems.isEmpty {
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(cartViewModel.cartItems, id: \.id) { shirt in
                            HStack {
                                Image(systemName: "tshirt.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                
                                VStack(alignment: .leading) {
                                    Text(shirt.title)
                                        .font(.headline)
                                    Text("Price: \(shirt.price.formatted(.currency(code: "EUR")))")
                                        .font(.subheadline)
                                    Text("Size: \(shirt.size)".uppercased())
                                        .font(.caption)
                                }
                                .padding()
                                
                                Spacer()
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete { offsets in
                            cartViewModel.removeFromCart(at: offsets)
                        }
                    }

                    NavigationLink(destination: CheckoutView(
                                    nameFromCheckout: $nameFromCheckout,
                                    streetFromCheckout: $streetFromCheckout,
                                    cityFromCheckout: $cityFromCheckout)
                        .environmentObject(cartViewModel)) {
                        Text("Proceed to Checkout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Your Cart")
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
