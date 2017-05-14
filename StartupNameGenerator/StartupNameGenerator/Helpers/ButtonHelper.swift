//
//  ButtonHelper.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Struct containing properties that are shared between the buttons
struct ButtonHelper {

    /// Defining a default font style to be used in the buttons across the application
    static var defaultNSAttributes: [String: Any] {
        return [
            NSFontAttributeName: TypographyHelper.customFont("Helvetica",
                                                             using: .body,
                                                             with: .bold)
        ]
    }
}
