//
//  CheckoutView.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import SwiftUI

struct CheckoutView: View {
    @State private var name: String = ""
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var isNavigatingToSummary = false

    @Binding var nameFromCheckout: String
    @Binding var streetFromCheckout: String
    @Binding var cityFromCheckout: String

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Shipping Information")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)

                    TextField("Street", text: $street)
                        .textFieldStyle(.roundedBorder)

                    TextField("City", text: $city)
                        .textFieldStyle(.roundedBorder)
                }

                Section {
                    Button(action: {
                        nameFromCheckout = name
                        streetFromCheckout = street
                        cityFromCheckout = city
                        isNavigatingToSummary = true
                    }) {
                        Text("Place Order")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(name.isEmpty || street.isEmpty || city.isEmpty)
                }
            }
            .navigationTitle("Checkout")
            .navigationDestination(isPresented: $isNavigatingToSummary) {
                OrderSummaryView(name: nameFromCheckout, street: streetFromCheckout, city: cityFromCheckout)
            }
        }
    }
}

#Preview {
    CheckoutView(nameFromCheckout: .constant(""), streetFromCheckout: .constant(""), cityFromCheckout: .constant(""))
}
