//
//  ContentView.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let desserts = try await NetworkManager.shared.getDesserts()
                let dessert = try await NetworkManager.shared.getDessertDetails(for: "53049")
                print(desserts)
                print()
                print(dessert)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
