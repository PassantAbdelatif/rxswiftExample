//
//  UIFont+SwiftHub.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import UIKit
import Foundation

// MARK: Main Fonts

extension UIFont {

    static func navigationTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }

    static func titleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }

    static func descriptionFont() -> UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
}

// MARK: Custom Fonts

extension UIFont {
    static func getFont(with type: CustomFontType,
                        size: CGFloat) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size)!
        
        return font
    }
}

// MARK: All Fonts

extension UIFont {

    static func allSystemFontsNames() -> [String] {
        var fontsNames = [String]()
        let fontFamilies = UIFont.familyNames
        for fontFamily in fontFamilies {
            let fontsForFamily = UIFont.fontNames(forFamilyName: fontFamily)
            for fontName in fontsForFamily {
                fontsNames.append(fontName)
            }
        }
        return fontsNames
    }
}

// MARK: Randomizing Fonts

extension UIFont {

    static func randomFont(ofSize size: CGFloat) -> UIFont {
        let allFontsNames = UIFont.allSystemFontsNames()
        let fontsCount = UInt32(allFontsNames.count)
        let randomFontIndex = Int(arc4random_uniform(fontsCount))
        let randomFontName = allFontsNames[randomFontIndex]
        return UIFont(name: randomFontName, size: size)!
    }
}
