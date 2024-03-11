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
                Text("default_error_description")
                    .font(.title)

                Text("\(error.localizedDescription)")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondaryLabel)
                    .multilineTextAlignment(.center)
            }

            Button("retry_title") { retryHandler() }
                .buttonStyle(.borderedProminent)

        }.padding()
    }
}

#Preview {
    DefaultErrorView(error: NSError(domain: "", code: -1), retryHandler: {})
}
