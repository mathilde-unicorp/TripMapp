//
//  RefugesInfo+PointType.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 22/08/2023.
//

import Foundation
import SwiftUI

extension RefugesInfo {

    // MARK: - Default Values

    // MARK: - Point Type Structure

    struct PointType: Codable, Hashable {
        let id: Int
        let value: String
        let iconName: String

        var icon: Image {
            if let systemIconName = MapPointType(refugesInfoId: id)?.systemIconName {
                return Image(systemName: systemIconName)
            } else {
                return Image(iconName)
            }
        }

        // MARK: - Coding Keys

        enum CodingKeys: String, CodingKey {
            case id
            case value = "valeur"
            case iconName = "icone"
        }

        // MARK: - Default values

        static let crossingPoint = MapPointType.crossingPoint.toRefugesInfoPointType
        static let refuge = MapPointType.refuge.toRefugesInfoPointType
        static let summit = MapPointType.summit.toRefugesInfoPointType
        static let hut = MapPointType.hut.toRefugesInfoPointType
        static let bedAndBreakfast = MapPointType.bedAndBreakfast.toRefugesInfoPointType
        static let bivouac = MapPointType.bivouac.toRefugesInfoPointType
        static let water = MapPointType.water.toRefugesInfoPointType
        static let lake = MapPointType.lake.toRefugesInfoPointType
    }

}
