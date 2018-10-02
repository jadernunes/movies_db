//
//  UIColor+Extension.swift
//  MoviesDB
//
//  Created by Jader Nunes on 2018-09-18.
//  Copyright © 2018 Jader Nunes. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //MARK: - Custom colors
    
    class func base() -> UIColor {
        return UIColor.hexStringToUIColor("#000000") ?? UIColor.black
    }
    
    class func title() -> UIColor {
        return UIColor.white
    }
    
    class func subInformation() -> UIColor {
        return UIColor.hexStringToUIColor("#9A9A9A") ?? UIColor.lightGray
    }
    
    //MARK: - Generic method to convert hex color
    
    /// Will return a UIColor according to the hexadecimal string passed, must be 6 characters long otherwise will return a gray color
    ///
    /// - Parameter hex: string describing the color in hexadecimal, may have a '#' prepended
    /// - Returns: UIColor for the hexadecimal representation
    class func hexStringToUIColor (_ hex: String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)...])
        }
        
        if ((cString.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
