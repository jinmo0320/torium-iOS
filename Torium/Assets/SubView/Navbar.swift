//
//  Toolbar.swift
//  Torium
//
//  Created by 최진모 on 2/16/26.
//
import SwiftUI

struct NavbarModifier: ViewModifier {
    let back: (() -> Void)?
    let root: (() -> Void)?
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            HStack {
                if let action = back {
                    ZStack {
                        Circle()
                            .fill(Color.BlackSoft)
                            .frame(width: 40, height: 40)
                        
                        Button {
                            action()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    }
                }

                Spacer()
                
                if let action = root {
                    ZStack {
                        Circle()
                            .fill(Color.BlackSoft)
                            .frame(width: 40, height: 40)
                        
                        Button {
                            action()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(Color.BlackSteel)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            .background(Color.clear)
            
            content
        }
        .navigationBarBackButtonHidden()
    }
}

extension View {
    func navbar(back: (()->Void)? = nil, root: (()->Void)? = nil) -> ModifiedContent<Self, NavbarModifier> {
        return modifier(NavbarModifier(back: back, root: root))
    }
}
