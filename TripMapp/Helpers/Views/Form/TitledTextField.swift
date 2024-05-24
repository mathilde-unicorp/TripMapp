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
        GeometryReader { proxy in
            HStack {
                Text(title)
                    .lineLimit(1)
                    .frame(minWidth: proxy.size.width * 0.3, alignment: .leading)

                TextField(placeholder, text: $text)
            }
        }

    }
}

#Preview {
    TitledTextField(
        title: "project",
        placeholder: "project_name_example",
        text: .constant("")
    )
}
