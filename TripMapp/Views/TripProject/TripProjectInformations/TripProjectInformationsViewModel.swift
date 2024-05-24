//
//  TripProjectCreateViewModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import Foundation

struct ImportedFile: Identifiable {
    let id = UUID()
    let url: URL
    let name: String
}

class TripProjectInformationsViewModel: ObservableObject {
    @Published var name: String = ""

    @Published var files: [ImportedFile] = [
        .init(url: URL(string: "local.url")!, name: "File 1"),
        .init(url: URL(string: "local.url")!, name: "File 2")
    ]

    @Published var startDate: String = ""

    @Published var endDate: String = ""

    @Published var notes: String = ""

    init(name: String, files: [ImportedFile], startDate: String, endDate: String, notes: String) {
        self.name = name
        self.files = files
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
    }
}
