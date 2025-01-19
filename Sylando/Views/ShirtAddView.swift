//
//  ShirtAddView.swift
//  Sylando
//
//  Created by Michael Winkler on 14.01.25.
//

import SwiftUI

struct ShirtAddView: View {
    @EnvironmentObject var shirtsViewModel: ShirtsViewModel
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var size: Size = .m
    @State private var isQuotePickerPresented: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Details").font(.headline)) {
                    if let quote = shirtsViewModel.quote {
                        ZStack {
                            Image(systemName: "tshirt.fill")
                                .font(.system(size: 200))
                                .fontWeight(.ultraLight)
                                .foregroundStyle(.purple)
                            
                            Text(quote.text)
                                .font(.caption)
                                .fontWeight(.bold)
                                .frame(width: 110)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 20)
                    }
                    
                    Button("Load New Quote") {
                        Task {
                            await shirtsViewModel.fetchQuote()
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Button("Choose a Quote from List") {
                        shirtsViewModel.loadQuotes()
                        isQuotePickerPresented.toggle()
                    }
                    .padding(.bottom, 20)
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Picker("Size", selection: $size) {
                        ForEach(Size.allCases) { size in
                            Text(size.title).tag(size)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.top, 10)
                }
                
                Button("Add Shirt") {
                    if let priceValue = Double(price), !title.isEmpty {
                        let newShirt = Shirt(title: title, price: priceValue, size: size.rawValue)
                        shirtsViewModel.addShirt(newShirt)
                        isPresented = false
                    } else {
                        errorMessage = "Please enter a valid title and price."
                    }
                }
            }
            .navigationTitle("Add a New Shirt")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
            .onAppear {
                Task {
                    await shirtsViewModel.fetchQuote()
                }
            }
            .sheet(isPresented: $isQuotePickerPresented) {
                QuotePickerView(quotes: shirtsViewModel.quotes) { selectedQuote in
                    shirtsViewModel.selectQuote(selectedQuote)
                    isQuotePickerPresented = false
                }
            }
        }
    }
}

#Preview {
    ShirtAddView(isPresented: .constant(false))
        .environmentObject(ShirtsViewModel())
}
