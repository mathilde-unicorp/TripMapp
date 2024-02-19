//
//  LoadingState.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/02/2024.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading): 
            return true
        default: return false
        }
    }
}
