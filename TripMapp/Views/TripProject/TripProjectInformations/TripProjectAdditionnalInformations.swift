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
            TitledTextField(
                title: "start_date",
                placeholder: "start_date_example",
                text: $startDate
            )

            TitledTextField(
                title: "end_date",
                placeholder: "end_date_example",
                text: $endDate
            )

            TitledTextField(
                title: "notes",
                placeholder: "notes_placeholder",
                text: $notes
            )
        }
    }
}

#Preview {
    TripProjectAdditionnalInformations(
        startDate: .constant(""),
        endDate: .constant(""),
        notes: .constant("")
    )
}
