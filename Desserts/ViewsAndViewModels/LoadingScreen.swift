//
//  LoadingScreen.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(.iceCreamDog)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            ProgressView()
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingScreen()
}
