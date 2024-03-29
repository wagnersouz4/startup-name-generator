//
//  FavoritableTableViewCell.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

protocol FavoritableTableViewCellButtonDelegate: class {
    func didPressButton(_ sender: IndexedUIButton)
}

class FavoritableTableViewCell: UITableViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: IndexedUIButton!

    weak var buttonDelegate: FavoritableTableViewCellButtonDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with startupName: StartupName, indexPath: IndexPath, highlight: Bool = false) {

        let fontWeight: FontWeight = (highlight) ? .bold : .regular

        nameLabel.font = TypographyHelper.customFont("Helvetica", using: .body, with: fontWeight)
        nameLabel.text = startupName.description
        favoriteButton.indexPath = indexPath

        let image = (startupName.isFavorited) ? #imageLiteral(resourceName: "favorited") : #imageLiteral(resourceName: "unfavorited")
        favoriteButton.setBackgroundImage(image, for: .normal)
    }

    @IBAction func didPressButton(_ sender: IndexedUIButton) {
        self.buttonDelegate?.didPressButton(sender)
    }
}
