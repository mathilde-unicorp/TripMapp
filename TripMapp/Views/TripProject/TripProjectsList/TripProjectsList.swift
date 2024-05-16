//
//  TripProjectsList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

struct TripProjectsList: View {

    @Binding var selectedProject: TripProject?

    @State private var projects = [
        TripProject(name: "Project 1"),
        TripProject(name: "Project 2"),
        TripProject(name: "Project 3"),
        TripProject(name: "Project 4")
    ]

    var body: some View {
        List(projects, selection: $selectedProject) { project in
            NavigationLink(value: project, label: {
                TripProjectRow(project: project)
            })
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TripProjectsList(selectedProject: .constant(nil))
    }
}
