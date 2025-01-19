//
//  HTTPError.swift
//  Sylando
//
//  Created by Michael Winkler on 17.01.25.
//

import Foundation

enum HTTPError: Error {
    case invalidURL, fetchFailed

    var message: String {
        switch self {
        case .invalidURL: return "Die URL ist ungültig"
        case .fetchFailed: return "Laden ist fehlgeschlagen"
        }
    }
}
