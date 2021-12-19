//
//  UIColor+Asset.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit

extension UIColor {
    static var primaryBackground: UIColor { UIColor(named: "primaryBackground") ?? .white }
    
    static var primaryFont: UIColor { UIColor(named: "primaryFont") ?? .black }
    
    static func progressColour(_ progress: CGFloat) -> UIColor {
        switch progress {
        case -CGFloat.greatestFiniteMagnitude..<0.33: return UIColor.systemRed
        case 0.33..<0.66: return UIColor.systemYellow
        case 0.66 ..< CGFloat.greatestFiniteMagnitude: return UIColor.systemGreen
        default: return UIColor.systemRed
        }
    }
}
