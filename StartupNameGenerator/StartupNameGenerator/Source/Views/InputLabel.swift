//
//  InputLabel.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Describing the labels used to explain e textView
class InputLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    private func configureUI() {
        textColor = .white
        font = TypographyHelper.customFont("Helvetica", using: .body, with: .light)
    }

}
