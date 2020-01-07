//
//  UIFontExtension.swift
//  DragDrop
//

import UIKit

extension UIFont {
    static func appFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    static func appFontBold(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func appFontMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
