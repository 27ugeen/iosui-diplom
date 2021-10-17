//
//  ColorSet.swift
//  MyHabits
//
//  Created by GiN Eugene on 8/29/21.
//

import Foundation

import UIKit

public let buttonColor = UIColor(rgb: 0xA116CC)
public let appMainTextColor = UIColor(rgb: 0x000000)
public let mainBackgroundColor = UIColor(rgb: 0xF2F2F7)
public let secondBackgroundColor = UIColor(rgb: 0xFFFFFF)
public let mainLabelTextColor = UIColor(rgb: 0x8E8E93)
public let secondLabelTextColor = UIColor(rgb: 0xAEAEB2)
public let headLineColor = UIColor(rgb: 0x296DFF)


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
