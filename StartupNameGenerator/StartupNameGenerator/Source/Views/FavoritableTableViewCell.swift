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
        configureUI()
    }

    private func configureUI() {
        nameLabel.font = TypographyHelper.customFont("Helvetica", using: .body, with: .regular)
    }

    func setup(with name: Name, indexPath: IndexPath) {
        nameLabel.text = name.description
        favoriteButton.indexPath = indexPath

        if name.isFavorited {
            //favoriteButton.imageView?.image = #imageLiteral(resourceName: "favorited")
            favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favorited"), for: .normal)
        }
    }

    @IBAction func didPressButton(_ sender: IndexedUIButton) {
        self.buttonDelegate?.didPressButton(sender)
    }
}
