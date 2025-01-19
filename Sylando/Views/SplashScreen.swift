//
//  SplashScreen.swift
//  Sylando
//
//  Created by Michael Winkler on 19.01.25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var showMainView = false

    var body: some View {
        ZStack {
            if showMainView {
                NavigatorView()
            } else {
                AnimationSylando()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    SplashScreen()
        .preferredColorScheme(.dark)
}
