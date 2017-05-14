//
//  TitleLabel.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Describing label that should be displayed as title in the app
class TitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    private func configureUI() {
        font = TypographyHelper.customFont("Copperplate",
                                           using: .title2,
                                           with: .bold)
        textColor = .brightGreen
    }
}
