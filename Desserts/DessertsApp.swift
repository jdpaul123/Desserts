//
//  DessertsApp.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import SwiftUI

@main
struct DessertsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DessertListScreen(viewModel: DessertListScreenViewModel())
            }
        }
    }
}
