//
//  PullToRefreshView.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

struct PullToRefreshView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(.iceCreamDog)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                        .padding()
                    Text("An error occured. Please pull to refresh the screen.")
                        .padding(.all, 20)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    PullToRefreshView()
}
