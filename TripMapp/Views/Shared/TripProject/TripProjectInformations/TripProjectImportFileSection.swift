//
//  ImportedFileList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

struct TripProjectImportFileSection: View {
    @Binding var files: [ImportedFile]

    var body: some View {
        Section("import_external_content") {
            ForEach(files) { file in
                ImportedFileRow(name: file.name)
                    .onDelete {
                        files.removeAll { $0.id == file.id }
                    }
            }

            Button {
                print("Import a file action")
                withAnimation {
                    files.append(.init(
                        url: URL(string: "local.url")!,
                        name: "New file \(Int.random(in: 0 ... 10))")
                    )
                }
            } label: {
                ImportFileRow()
            }
        }
    }
}

#Preview {
    List {
        TripProjectImportFileSection(files: .constant([
            .init(url: URL(string: "local.url")!, name: "File 1"),
            .init(url: URL(string: "local.url")!, name: "File 2")
        ]))
    }
}
