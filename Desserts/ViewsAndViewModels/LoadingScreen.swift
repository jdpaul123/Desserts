//
//  LoadingScreen.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var isRotating = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Image(.iceCreamDog)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 1)
                        .speed(0.1).repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
                .padding()
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingScreen()
}
