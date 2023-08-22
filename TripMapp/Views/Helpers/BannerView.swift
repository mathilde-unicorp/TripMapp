//
//  BannerView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/05/2023.
//

import SwiftUI

enum BannerType {
    case success
    case information
    case warning
    case error
    case debug

    var bannerColor: Color {
        switch self {
        case .information: return .blue
        case .error: return .red
        case .warning: return .orange
        case .success: return .green
        case .debug: return .gray
        }
    }
}

struct BannerView: View {
    @Binding var isPresented: Bool
    @State var text: String
    @State var bannerType: BannerType
    
    var body: some View {
        if isPresented {
            HStack {
                Text(text)
                    .font(.subheadline)
                    .colorInvert()

                Spacer()

                Image(systemName: "x.circle")
                    .colorInvert()
            }
            .onTapGesture {
                withAnimation {
                    isPresented = false
                }
            }
            .padding()
            .background(bannerType.bannerColor)

        } else {
            EmptyView()
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(isPresented: .constant(true), text: "Ooops", bannerType: .error)
    }
}
