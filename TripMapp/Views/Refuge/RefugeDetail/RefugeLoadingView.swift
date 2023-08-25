//
//  RefugeLoadingView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 25/08/2023.
//

import SwiftUI

struct RefugeLoadingView: View {
    let isLoading: Bool

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(height: 400)
                .overlay {
                    Image(systemName: "globe.asia.australia.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(32.0)
                        .foregroundColor(Color(UIColor.tertiarySystemBackground))

                }

            if isLoading {
                ProgressView()
                    .padding(32.0)
            }

            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct RefugeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeLoadingView(isLoading: true)
    }
}
