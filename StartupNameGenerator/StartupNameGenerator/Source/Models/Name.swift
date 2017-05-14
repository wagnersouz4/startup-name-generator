//
//  Name.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import Foundation

struct Name {
    let description: String
    var isFavorited: Bool

    init(description: String, isFavorited: Bool) {
        self.description = description
        self.isFavorited = isFavorited
    }

    init(description: String) {
        self.init(description: description, isFavorited: false)
    }
}
