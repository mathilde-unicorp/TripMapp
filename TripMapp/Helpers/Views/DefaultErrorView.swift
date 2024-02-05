//
//  DefaultErrorView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/01/2024.
//

import SwiftUI

struct DefaultErrorView: View {
    let error: Error
    let retryHandler: () -> Void

    var body: some View {
        VStack(spacing: 24.0) {
            VStack {
                Text("Oops, an error occured.")
                    .font(.title)

                Text("\(error.localizedDescription)")
                    .font(.subheadline)
                    .foregroundStyle(Color(UIColor.secondaryLabel))
                    .multilineTextAlignment(.center)
            }

            Button("Retry") { retryHandler() }
                .buttonStyle(.borderedProminent)

        }.padding()
    }
}

#Preview {
    DefaultErrorView(error: NSError(domain: "", code: -1), retryHandler: {})
}