//
//  LoadingTask.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/05/2023.
//

import SwiftUI

struct LoadingTask: ViewModifier {
    @Binding var isLoading: Bool

    var action: () async throws -> Void

    func body(content: Content) -> some View {
        content
            .task {
                self.isLoading = true

                do {
                    try await action()
                    self.isLoading = false
                } catch {
                    self.isLoading = false
                }
            }
    }
}

extension View {
    func loadingTask(
        priority: TaskPriority = .userInitiated,
        isLoading: Binding<Bool>,
        _ action: @escaping () async throws -> Void
    ) -> some View {
        modifier(LoadingTask(isLoading: isLoading, action: action))
    }
}
