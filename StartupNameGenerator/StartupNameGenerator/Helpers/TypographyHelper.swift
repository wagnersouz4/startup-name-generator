//
//  TypographyHelper.swift
//  StartupNameGenerator
//
//  Created by Wagner Souza on 13/05/17.
//  Copyright © 2017 Wagner Souza. All rights reserved.
//

import UIKit

/// Describing all posible font's weight
enum FontWeight: String {
    case ultraLight = "Ultralight"
    case thin = "Thin"
    case light = "Light"
    case regular = ""
    case medium = "Medium"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case heavy = "Heavy"
    case black = "Black"
    var value: CGFloat {
        switch self {
        case .ultraLight:
            return UIFontWeightUltraLight
        case .thin:
            return UIFontWeightThin
        case .light:
            return UIFontWeightLight
        case .regular:
            return UIFontWeightRegular
        case .medium:
            return UIFontWeightMedium
        case .semiBold:
            return UIFontWeightSemibold
        case .bold:
            return UIFontWeightBold
        case .heavy:
            return UIFontWeightHeavy
        case .black:
            return UIFontWeightBlack
        }
    }
}

struct TypographyHelper {

    private static func pointSize(for textStyle: UIFontTextStyle) -> CGFloat {
        return UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
    }

    /// Generating a system font according to UIFontStyle and weight
    static func generateFont(using textStyle: UIFontTextStyle, with fontWeight: FontWeight) -> UIFont {
        let size = pointSize(for: textStyle)
        return UIFont.systemFont(ofSize: size, weight: fontWeight.value)
    }

    /// Generate a custom font
    static func customFont(_ name: String, using textStyle: UIFontTextStyle, with fontWeight: FontWeight) -> UIFont {
        let size = pointSize(for: textStyle)

        let fontName = (fontWeight.rawValue != "") ? "\(name)-\(fontWeight.rawValue)" : "\(name)\(fontWeight.rawValue)"

        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Error while creating font \(fontName)")
        }
        return font
    }
}
