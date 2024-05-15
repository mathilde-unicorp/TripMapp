//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectCreateView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("project_name")
                    TextField("project_name_example", text: .constant(""))
                }
            } header: {
                Image("ProjectImagePlaceholder")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
            }

            Section("import_external_content") {
                Label("_example_gpx_file_name", systemImage: "arrow.triangle.swap")
            }

            Section("project_additionnal_informations") {
                HStack {
                    Text("start_date")
                    TextField("start_date_example", text: .constant(""))
                }
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
