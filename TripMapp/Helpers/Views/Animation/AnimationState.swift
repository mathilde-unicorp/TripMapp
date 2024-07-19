//
//  AnimationState.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/09/2024.
//

import Foundation
import SwiftUI

/// Basic animation states for view
enum AnimationState {
    /// Default state, nothing happens
    case idle
    /// Trigger the success animation
    case success
    /// Trigger the error animation
    case error
}

// =============================================================================
// MARK: - View+AnimationState
// =============================================================================

extension View {

    /// When the value of the `animationState` change to something else than an `.idle` state
    /// It's reset to `idle` after `duration` seconds
    func resetToIdle(_ animationState: Binding<AnimationState>, after duration: CGFloat) -> some View {
        self.onChange(of: animationState.wrappedValue) { _, state in
            if state != .idle {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    animationState.wrappedValue = .idle
                }
            }
        }
    }
}
