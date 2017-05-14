//
//  RoundedCornersButton.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Create a button with rounded corners
class RoundedCornersButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    private func configureUI() {
        // Rounded corners
        layer.cornerRadius = 6
        clipsToBounds = true

        // Setting the text color for all rounded button in the app
        self.setTitleColor(.white, for: .normal)

        // Setting the default font to be used
        titleLabel?.attributedText = NSAttributedString(string: currentTitle ?? "Button",
                                                        attributes: ButtonHelper.defaultNSAttributes)

    }

}
