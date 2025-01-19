//
//  ShirtAddViewModel.swift
//  Sylando
//
//  Created by Michael Winkler on 19.01.25.
//

import Foundation
import Combine

class ShirtAddViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var size: Size = .m
    @Published var errorMessage: String? = nil
    
    private var shirtsViewModel: ShirtsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(shirtsViewModel: ShirtsViewModel) {
        self.shirtsViewModel = shirtsViewModel
    }
    
    func validateInputs() -> Bool {
        if title.isEmpty || Double(price) == nil {
            errorMessage = "Please enter a valid title and price."
            return false
        }
        return true
    }
    
    @MainActor func addShirt() {
        if validateInputs() {
            let priceValue = Double(price)!
            let newShirt = Shirt(title: title, price: priceValue, size: size.rawValue)
            shirtsViewModel.addShirt(newShirt)
        }
    }
    
    func fetchNewQuote() async {
        await shirtsViewModel.fetchQuote()
    }
    
    @MainActor func selectQuote(_ quote: Quote) {
        shirtsViewModel.selectQuote(quote)
    }
}
