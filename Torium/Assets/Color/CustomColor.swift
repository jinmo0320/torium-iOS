//
//  CustomColor.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

extension Color {
    static let Brand = Color(hex: "#AA66AA")
    static let Background = Color(hex: "#F8F9FA")
    
    static let White = Color(hex: "#FFFFFF")
    static let WhiteSoft = Color(hex: "#FFFFFF").opacity(0.5)
    static let WhiteMist = Color(hex: "#FFFFFF").opacity(0.2)
    
    static let Black = Color(hex: "#000000")
    static let BlackInk = Color(hex: "#2B2B2B")
    static let BlackMidnight = Color(hex: "#3D3D3D")
    static let BlackSteel = Color(hex: "#666666")
    static let BlackPlaceholder = Color(hex: "#999999")
    static let BlackSoft = Color(hex: "#EDEDED")
    static let BlackMist = Color(hex: "#F8F8F8")
    static let Green = Color(hex: "#88B04B")
    static let RedWarning = Color(hex: "#9D202F")
    static let RedSoft = Color(hex: "#D17878")
    static let Cloud = Color(hex: "#F0EEE9")
    static let Soda = Color(hex: "#E5F7FF")
    
    static let brandPrimary = Color(hex: "#AA66AA")
    static let labelPrimary = Color(hex: "#2B2B2B")
    static let labelWhite = Color(hex: "#FFFFFF")
    static let labelRed = Color(hex: "#D17878")
    static let labelGreen = Color(hex: "#5FB88D")
    static let labelPlaceholder = Color(hex: "#999999")
    static let labelDisabled = Color.labelWhite.opacity(0.6)
    
    static let buttonPrimary = Color(hex: "#3D3D3D")
    static let buttonDisabled = Color(hex: "#3C3C43").opacity(0.6)
    
    static let borderPrimary = Color(hex: "#B5B5B5")

}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
