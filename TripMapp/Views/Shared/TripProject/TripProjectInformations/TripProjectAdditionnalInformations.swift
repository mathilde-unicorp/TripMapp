//
//  TropProjectAdditionnalInformations.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectAdditionnalInformations: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var notes: String

    var endDateRange: ClosedRange<Date> {
        return startDate ... Date.distantFuture
    }

    var body: some View {
        Section("project_additionnal_informations") {
            FormField("start_date") {
                DatePicker(
                    "",
                     selection: $startDate,
                     displayedComponents: [.date]
                )
            }

            FormField("end_date") {
                DatePicker(
                    "",
                     selection: $endDate,
                     in: endDateRange,
                     displayedComponents: [.date]
                )
            }

            FormField("notes", axis: .vertical) {
                TextField("notes_placeholder", text: $notes, axis: .vertical)
            }
        }
        .onChange(of: startDate) {
            if startDate.isAfter(endDate) {
                endDate = startDate.adding(days: 1)
            }
        }
    }
}

#Preview {
    List {
        TripProjectAdditionnalInformations(
            startDate: .constant(.now),
            endDate: .constant(.now.adding(days: 7)),
            notes: .constant("")
        )
    }
}
