//  ShirtsViewModel.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import Foundation

@MainActor
class ShirtsViewModel: ObservableObject {
    private let quoteRepository = QuoteRepository()
    
    @Published var quote: Quote? = nil
    @Published var quotes: [Quote] = []
    @Published var shirts: [Shirt] = []
    
    func addShirt(_ shirt: Shirt) {
        shirts.append(shirt)
    }
    
    func deleteShirt(_ shirt: Shirt) {
        shirts.removeAll { $0.id == shirt.id }
    }
    
    @MainActor
    func fetchQuote() async {
        do {
            self.quote = try await quoteRepository.getQuoteFromAPI()
        } catch {
            print("Failed to fetch quote: \(error)")
        }
    }
    
    @MainActor
    func fetchQuotes() async {
        do {
            quotes = try await quoteRepository.getAllQuotesFromAPI(limit: 999)
        } catch {
            print("Failed to fetch quotes: \(error)")
        }
    }
    
    func loadQuotes() {
        Task {
            await fetchQuotes()
        }
    }
    
    func selectQuote(_ quote: Quote) {
        self.quote = quote
    }
}
