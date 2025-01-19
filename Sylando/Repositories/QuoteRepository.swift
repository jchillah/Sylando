//
//  QuoteRepository.swift
//  Sylando
//
//  Created by Michael Winkler on 17.01.25.
//

import Foundation

class QuoteRepository {
    func getQuoteFromAPI() async throws -> Quote? {
        let urlString = "https://api.syntax-institut.de/quotes?language=DE"

        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)

        return result.first
    }

    func getAllQuotesFromAPI(limit: Int) async throws -> [Quote] {
        let urlString = "https://api.syntax-institut.de/quotes?limit=999"

        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)

        return result
    }
}
