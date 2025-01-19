//
//  QuotePickerView.swift
//  Sylando
//
//  Created by Michael Winkler on 18.01.25.
//

import SwiftUI

struct QuotePickerView: View {
    var quotes: [Quote]
    var onSelectQuote: (Quote) -> Void
    
    var body: some View {
        NavigationStack {
            List(quotes, id: \.id) { quote in
                Button(action: {
                    onSelectQuote(quote)
                }) {
                    Text(quote.text)
                        .font(.body)
                        .padding()
                }
            }
            .navigationTitle("Choose a Quote")
        }
    }
}

#Preview {
    let quotes = [
        Quote(id: "1", author: "", text: "This is a test quote 1"),
        Quote(id: "2", author: "", text: "This is a test quote 2"),
        Quote(id: "3", author: "", text: "This is a test quote 3")
    ]
    
    QuotePickerView(quotes: quotes) { selectedQuote in
        print("Selected Quote: \(selectedQuote.text)")
    }
}
