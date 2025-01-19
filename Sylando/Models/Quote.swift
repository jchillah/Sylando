//
//  Quote.swift
//  Sylando
//
//  Created by Michael Winkler on 17.01.25.
//

import Foundation

struct Quote: Codable, Identifiable {
    var id: String
    var author: String
    var text: String
}
