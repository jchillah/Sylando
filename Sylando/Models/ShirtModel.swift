//
//  ShirtModel.swift
//  Sylando
//
//  Created by Michael Winkler on 13.01.25.
//

import Foundation

enum Size: String, Identifiable, CaseIterable {
    case xs, s, m, l, xl

    var id: String { rawValue }

    var title: String {
        switch self {
        case .xs: return "XS"
        case .s: return "S"
        case .m: return "M"
        case .l: return "L"
        case .xl: return "XL"
        }
    }
}

struct Shirt: Identifiable {
    let id = UUID()
    let title: String
    let price: Double
    let size: String

    init(id: UUID = UUID(), title: String, price: Double, size: String) {
        self.title = title
        self.price = price
        self.size = size
    }
}
