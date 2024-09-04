//
//  UIApplication+sounds.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 18/07/2024.
//

import UIKit
import AVFoundation

/// Apple system sounds used in the app
enum SystemSounds {
    case smsReceived
    case workoutSavedHaptic

    var urlString: String {
        switch self {
        case .smsReceived: "sms-received5.caf"
        case .workoutSavedHaptic: "nano/WorkoutSaved_Haptic.caf"
        }
    }

    var url: URL? {
        return URL(fileURLWithPath: "/System/Library/Audio/UISounds/\(urlString)")
    }
}

// =============================================================================
// MARK: - UIApplication
// =============================================================================

extension UIApplication {

    /// Instantly play a system sound
    static func play(sound: SystemSounds) {
        guard let url = sound.url else {
            print("Cannot get system sound URL :(")
            return
        }

        var systemSoundID: SystemSoundID = 1013 // doesnt matter; edit path instead
        AudioServicesCreateSystemSoundID(url as CFURL, &systemSoundID)
        AudioServicesPlaySystemSound(systemSoundID)
    }
}
