//
//  CleanButton.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Default properties to the clean button
class CleanButton: RoundedCornersButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .orange
    }

}
