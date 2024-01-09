//
//  View+Banner.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

extension View {
    func banner(data: Binding<BannerModifier.BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}
