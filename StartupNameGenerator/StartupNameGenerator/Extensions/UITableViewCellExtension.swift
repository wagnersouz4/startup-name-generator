//
//  UITableViewCellExtension.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 14/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

protocol IdentifiableCell: class {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension UITableViewCell: IdentifiableCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
}
