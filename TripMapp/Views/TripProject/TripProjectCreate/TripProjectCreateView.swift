//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectCreateView: View {
    @ObservedObject var viewModel: TripProjectCreateViewModel = .init()

    var body: some View {
        GeometryReader { proxy in
            Form {
                TripProjectNameAndImageSection(
                    name: $viewModel.name,
                    imageHeight: proxy.size.height * 0.3
                )

                TripProjectImportFileSection(files: $viewModel.files)

                TripProjectAdditionnalInformations(
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate,
                    notes: $viewModel.notes
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("continue") { }
            }
        }
        .navigationTitle("project.new")
    }
}

#Preview {
    NavigationStack {
        TripProjectCreateView()
    }
}
