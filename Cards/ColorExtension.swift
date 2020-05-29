//
//  ColorExtension.swift
//  MobileMoney
//
//  Created by Lizan Pradhanang on 10/17/17.
//  Copyright © 2017 Lizan Pradhanang. All rights reserved.
//

import UIKit

extension String {
    var length: Int {
        return self.count
    }
}


//extension UIColor{
//    
//    @nonobjc class var pinkishGrey16: UIColor {
//        return UIColor(red: 204.0 / 255.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 0.16)
//    }
//    
//    @nonobjc class var greyishBrown: UIColor {
//        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var veryLightPink: UIColor {
//        return UIColor(red: 1.0, green: 244.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
//    }
//    
//
//    @nonobjc class var rouge: UIColor {
//        return UIColor(red: 156.0 / 255.0, green: 39.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var veryLightPinkTwo: UIColor {
//        return UIColor(red: 252.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
//    }
// 
//    
//    @nonobjc class var scarlet: UIColor {
//        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var crimson: UIColor {
//        return UIColor(red: 139.0 / 255.0, green: 3.0 / 255.0, blue: 4.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var scarletTwo: UIColor {
//        return UIColor(red: 190.0 / 255.0, green: 0.0, blue: 7.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var pinkishRed: UIColor {
//        return UIColor(red: 237.0 / 255.0, green: 28.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var coolGrey: UIColor {
//        return UIColor(red: 149.0 / 255.0, green: 152.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
//    }
//    
//    @nonobjc class var pinkishGrey74: UIColor {
//        return UIColor(red: 204.0 / 255.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 0.74)
//    }
//    
//}

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
}




extension UIColor {
    
    static let tableViewBgColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
    static let tabBGColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
    static let chargesBGColor = UIColor(red:1.00, green:0.96, blue:0.96, alpha:1.0)
    static let lightDark = UIColor(red:0.44, green:0.44, blue:0.47, alpha:0.7)
    static let limeColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)

    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }

    convenience init(hexString: String) {

        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }

    convenience init(r: Int, g: Int, b: Int) {

        assert(r < 0 && r > 255 ,"Invalid red component")
        assert(g < 0 && g > 255 ,"Invalid green component")
        assert(b < 0 && b > 255 ,"Invalid blue component")

        self.init(
            red: (CGFloat(r) / 255.0),
            green: (CGFloat(g) / 255.0),
            blue: (CGFloat(b) / 255.0),
            alpha:1.0)

    }
}


