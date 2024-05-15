//
//  TitledTextField.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TitledTextField: View {
    var title: LocalizedStringKey
    var placeholder: LocalizedStringKey
    @Binding var text: String

    var body: some View {
        HStack {
            Text(title)

            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    TitledTextField(title: "project_name", placeholder: "project_name_example", text: .constant(""))
}
