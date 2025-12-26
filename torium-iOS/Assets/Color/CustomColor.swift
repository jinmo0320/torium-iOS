//
//  CustomColor.swift
//  torium-iOS
//
//  Created by 최진모 on 12/26/25.
//

import SwiftUI

extension Color {
    static let brandPrimary = Color(hex: "#B869EC")
    
    static let labelBlack = Color(hex: "#2B2B2B")
    static let labelWhite = Color(hex: "#FFFFFF")
    static let labelGray = Color(hex: "#999999")
    static let labelRed = Color(hex: "#D17878")
    
    static let buttonPrimary = Color(hex: "#3D3D3D")
    static let buttonDisabled = Color(hex: "#3C3C43").opacity(0.6)

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
