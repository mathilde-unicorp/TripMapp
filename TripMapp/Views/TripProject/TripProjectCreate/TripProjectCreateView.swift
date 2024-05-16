//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectCreateView: View {
    var project = TripProject(name: "")

    @ObservedObject var viewModel: TripProjectCreateViewModel = .init()

    var body: some View {
        GeometryReader { proxy in
            Form {
                Section {
                    TitledTextField(
                        title: "project_name",
                        placeholder: "project_name_example",
                        text: $viewModel.name
                    )
                } header: {
                    Image("ProjectImagePlaceholder")
                        .resizable()
                        .scaledToFill()
                        .listRowInsets(EdgeInsets(top: 8, leading: -24, bottom: 8, trailing: -24))
                        .frame(minHeight: 200.0, idealHeight: proxy.size.height * 0.3)
                        .clipped()
                        .padding(.bottom)
                        .overlay(alignment: .bottomTrailing) {
                            ImageButton(systemImage: "photo.fill") {
                            }
                            .shadow(radius: 10)
                            .padding(.trailing)
                            .padding(.bottom, 32.0)
                        }
                }

                Section("import_external_content") {
                    ForEach(viewModel.files) { file in
                        ImportedFileRow(name: file.name)
                            .onDelete {
                                viewModel.files.removeAll { $0.id == file.id }
                            }
                    }

                    ImportFileRow {
                        print("Import a file action")
                        withAnimation {
                            viewModel.files.append(.init(
                                url: URL(string: "local.url")!,
                                name: "New file \(Int.random(in: 0 ... 10))")
                            )
                        }
                    }
                }

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
