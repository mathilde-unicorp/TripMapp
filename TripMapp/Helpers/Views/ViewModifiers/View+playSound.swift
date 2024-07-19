//
//  UIView+playSound.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/09/2024.
//

import SwiftUI

private struct PlaySound: ViewModifier {
    @Binding var shouldPlaySound: Bool
    let sound: SystemSounds

    func body(content: Content) -> some View {
        content
            .onChange(of: shouldPlaySound) { _, shouldPlaySound in
                if shouldPlaySound {
                    UIApplication.play(sound: sound)

                    self.shouldPlaySound = !shouldPlaySound
                }
            }
    }
}

// =============================================================================
// MARK: - View extensions
// =============================================================================

extension View {
    /// Play a system sound when the `isPlaying` value is triggered
    func playSound(isPlaying: Binding<Bool>, sound: SystemSounds) -> some View {
        self.modifier(PlaySound(
            shouldPlaySound: isPlaying,
            sound: sound
        ))
    }
}

// =============================================================================
// MARK: - Preview
// =============================================================================

struct PlaySound_Previews: PreviewProvider {

    /// A view which will wraps the actual view and holds state variable.
    struct ContainerView: View {
        @State private var shouldPlaySound: Bool = false

        var body: some View {
            Button("Play Sound") {
                shouldPlaySound.toggle()
            }
            .playSound(isPlaying: $shouldPlaySound, sound: .workoutSavedHaptic)
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
