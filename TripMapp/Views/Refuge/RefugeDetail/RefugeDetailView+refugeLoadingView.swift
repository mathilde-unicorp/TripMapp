//
//  RefugeDetailView+refugeLoadingView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import SwiftUI

extension RefugeDetailView {
    
    // MARK: - Views

    @ViewBuilder
    static func refugeLoadingView(isLoading: Bool) -> some View {
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


struct RefugeDetailView_refugeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RefugeDetailView.refugeLoadingView(isLoading: true)
    }
}
