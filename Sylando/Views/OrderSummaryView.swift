//
//  OrderSummaryView.swift
//  Sylando
//
//  Created by Michael Winkler on 16.01.25.
//

import SwiftUI

struct OrderSummaryView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @StateObject private var shirtsViewModel = ShirtsViewModel()
    @State private var isOrderPlaced = false
    @State private var isShopping = false  

    @State private var name: String
    @State private var street: String
    @State private var city: String

    init(name: String, street: String, city: String) {
        _name = State(initialValue: name)
        _street = State(initialValue: street)
        _city = State(initialValue: city)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    Text("Name: \(name)")
                    Text("Street: \(street)")
                    Text("City: \(city)")
                }

                VStack {
                    Text("Checkout Summary")
                        .font(.headline)
                        .padding()
                    
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
                        }
                        .padding(.vertical, 5)
                    }
                }

                Section {
                    Text("Total: \(cartViewModel.cartItems.reduce(0) { $0 + $1.price }.formatted(.currency(code: "EUR")))")
                        .font(.headline)
                        .padding()
                }
                
                Section {
                    Button("Buy Now") {
                        cartViewModel.clearCart()
                        isOrderPlaced = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }

             
                Section {
                    Button("Continue Shopping") {
                       
                        isShopping = true
                    }
                    .padding()
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Order Summary")
            .navigationDestination(isPresented: $isOrderPlaced) {
                SuccessView()
            }
            .navigationDestination(isPresented: $isShopping) {
                ShirtListView()
            }
        }
    }
}

#Preview {
    OrderSummaryView(name: "John Doe", street: "123 Elm Street", city: "Sample City")
        .environmentObject(CartViewModel())
}
