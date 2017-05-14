//
//  Generator.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Foundation

struct Generator {
    func generateNames(using appDelegate: AppDelegate) -> [StartupName] {
        let favorites = StartupName.loadFavorites(using: appDelegate)
        let random = [
            StartupName(description: "A"),
            StartupName(description: "B"),
            StartupName(description: "D"),
            StartupName(description: "C"),
            StartupName(description: "F"),
            StartupName(description: "G"),
            StartupName(description: "H"),
            StartupName(description: "I")
        ]

        let names = random + favorites
        return names
    }
}
