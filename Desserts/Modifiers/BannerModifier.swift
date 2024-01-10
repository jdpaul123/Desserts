//
//  BannerModifier.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

enum BannerType {
    case info
    case warning
    case success
    case error

    var tintColor: Color {
        switch self {
        case .info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .success:
            return Color.green
        case .warning:
            return Color.yellow
        case .error:
            return Color.red
        }
    }
}

// This is the banner modifier from my UO Kiosk app
struct BannerModifier: ViewModifier {
    struct BannerData: Equatable {
        var title: String
        var detail: String
        var type: BannerType

        init(title: String = "", detail: String = "", type: BannerType = .error) {
            self.title = title
            self.detail = detail
            self.type = type
        }
    }

    @Binding var data: BannerData
    @Binding var show: Bool

     // Place the banner on top of the current view and keep there for 4 seconds or until the banner is tapped
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    Spacer()
                }
                .padding()
                .animation(.easeInOut, value: 0)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
            }
        }
    }
}

struct BannerModifierPreviewView: View {
    @State var showBanner = true
    @State var bannerData = BannerModifier.BannerData(title: "Default Title",
                                                      detail: "This is the detail text for the action you just did or whatever blah blah blah blah blah",
                                                      type: .info)

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Button(action: {
                self.bannerData.type = .info
                self.showBanner = true
            }) {
                Text("[ Info Banner ]")
            }
            Button(action: {
                self.bannerData.type = .success
                self.showBanner = true
            }) {
                Text("[ Success Banner ]")
            }
            Button(action: {
                self.bannerData.type = .warning
                self.showBanner = true
            }) {
                Text("[ Warning Banner ]")
            }
            Button(action: {
                self.bannerData.type = .error
                self.showBanner = true
            }) {
                Text("[ Error Banner ]")
            }
        }.banner(data: $bannerData, show: $showBanner)
    }
}

#Preview {
    BannerModifierPreviewView()
}
