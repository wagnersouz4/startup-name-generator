//
//  FavoritableTableViewCell.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

class FavoritableTableViewCell: UITableViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var favoritedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        nameLabel.font = TypographyHelper.customFont("Helvetica", using: .body, with: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(with name: Name) {
        nameLabel.text = name.description

        if name.isFavorited {
            favoritedImageView.image = #imageLiteral(resourceName: "favorited")
        }
    }
}
