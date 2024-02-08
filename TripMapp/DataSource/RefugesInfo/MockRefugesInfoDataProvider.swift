//
//  MockRefugesInfoData.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/08/2023.
//

import Foundation

final class MockRefugesInfoDataProvider: ObservableObject, RefugesInfoDataProviderProtocol {
    let refuges: [RefugesInfo.RefugePoint] = [
        RefugesInfo.RefugePoint(properties: .init(
            id: 0,
            link: URL(string: "https://www.refuges.info/point/3776/cabane-non-gardee/Cabane-pastorale-de-Clartan/")!,
            name: "Cabane pastorale de Clartan",
            symbol: "Crossing",
            coordinates: .init(
                altitude: 2013,
                longitude: "6.37203",
                latitude: "45.50609",
                precision: .init(name: "Coordonnées pointées sur photos aériennes", type: 7)
            ),
            type: .hut,
            capacity: .init(name: "Places prévues pour dormir", value: 0),
            maintenance: .init(valeur: "Détruite", id: "detruit"),
            date: .init(lastModified: .now, creation: .now),
            note: .init(
                name: "Remarque",
                value: "[color=green][b]Cette construction fait partie d'un plan d'aménagement du pastoralisme, tout autour du massif, avec la construction de cabanes strictement réservées aux bergers ; la séparation est ainsi effective d'avec les anciennes constructions qui sont désormais destinées aux autres utilisateurs de la montagne (chasseurs, randonneurs).[/b][/color]\r\nInutile donc de compter dessus, surtout à cette altitude où le bois n'existe pas.\r\n\r\n[b] * DETRUITE PAR UNE AVALANCHE !!*[/b]"
            ),
            access: .init(
                name: "Accès",
                value: "Sur le sentier \"tour des alpages\", entre la Vénitier et l'Arbesserie."
            ),
            owner: .init(name: "Propriétaire / accessibilité", value: ""),
            creator: .init(id: 1141, name: "Claude Mauguier"),
            article: .init(demonstrative: "cette", definite: "la", partitive: "d'une"),
            additionnalInfo: .init(
                officialSite: .init(name: "Site Internet", url: nil, value: nil),
                missingWall: .init(name: "", value: nil),
                fireplace: .init(name: "", value: nil),
                stove: .init(name: "", value: nil),
                blankets: .init(name: "", value: nil),
                mattressPlaces: .init(name: "Places sur Matelas", count: nil, value: "Sans"),
                toilets: .init(name: "", value: nil),
                wood: .init(name: "", value: nil),
                water: .init(name: "", value: nil)
            ),
            description: .init(value: "[color=green]*Cette construction fait partie d'un plan d'aménagement du pastoralisme, tout autour du massif, avec la construction de cabanes strictement réservées aux bergers ; la séparation est ainsi effective d'avec les anciennes constructions qui sont désormais destinées aux autres utilisateurs de la montagne (chasseurs, randonneurs).*[/color]\r\nInutile donc de compter dessus, surtout à cette altitude où le bois n'existe pas.\r\n\r\n* * DETRUITE PAR UNE AVALANCHE !!**Sur le sentier &quot;tour des alpages&quot;, entre la Vénitier et l'Arbesserie.")
        ), geometry: .init(coordinates: [6.37203, 45.50609]))
    ]

    func loadRefuge(id: RefugeId) async throws -> RefugesInfo.RefugePoint {
        return refuges[0]
    }

    func loadRefuges(
        massif: RefugesInfo.Massif,
        type: RefugesInfo.PointType?
    ) async throws -> [RefugesInfo.LightRefugePoint] {
        return refuges.map { $0.toLightPoint }
    }
}
