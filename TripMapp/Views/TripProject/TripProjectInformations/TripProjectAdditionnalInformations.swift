//
//  TropProjectAdditionnalInformations.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectAdditionnalInformations: View {
    @Binding var startDate: String
    @Binding var endDate: String
    @Binding var notes: String

    var body: some View {
        Section("project_additionnal_informations") {
            FormField("start_date") {
                TextField("start_date_example", text: $startDate)
            }

            FormField("end_date") {
                TextField("end_date_example", text: $endDate)
            }

            FormField("notes", axis: .vertical) {
                TextField("notes_placeholder", text: $notes, axis: .vertical)
            }
        }
    }
}

#Preview {
    List {
        TripProjectAdditionnalInformations(
            startDate: .constant(""),
            endDate: .constant(""),
            notes: .constant("")
        )
    }
}
