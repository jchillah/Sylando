//
//  SuccessView.swift
//  Sylando
//
//  Created by Michael Winkler on 16.01.25.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Thank you for your purchase!")
                .font(.largeTitle)
                .padding()
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Spacer()
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                dismiss()
            }
        }
    }
}

#Preview {
    SuccessView()
}

