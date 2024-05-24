//
//  TitledTextField.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct FormField<Field: View>: View {
    let titleKey: LocalizedStringKey
    let axis: Axis

    let field: () -> Field

    init(
        _ titleKey: LocalizedStringKey,
        axis: Axis = .horizontal,
        field: @escaping () -> Field
    ) {
        self.titleKey = titleKey
        self.axis = axis
        self.field = field
    }

    var body: some View {
        switch axis {
        case .horizontal:
            horizontalFormField()
        case .vertical:
            verticalFormField()
        }
    }

    @ViewBuilder
    private func horizontalFormField() -> some View {
        GeometryReader { proxy in
            HStack {
                buildTitle()
                    .frame(
                        // adapt title width to let enough space for text field
                        width: proxy.frame(in: .global).width * 0.3,
                        alignment: .leading
                    )

                field()
            }
        }
        .padding(.top, 6.0) // adjust for geometry reader
    }

    @ViewBuilder
    private func verticalFormField() -> some View {
        VStack(alignment: .leading) {
            buildTitle()
            field()
        }
    }

    @ViewBuilder private func buildTitle() -> some View {
        Text(titleKey)
            .font(.caption)
            .lineLimit(1)
    }
}

#Preview {
    List {
        FormField("project", axis: .horizontal) {
            TextField("project_name_example", text: .constant(""))
        }

        FormField("project", axis: .vertical) {
            TextField("project_name_example", text: .constant(""))
        }
    }
}
