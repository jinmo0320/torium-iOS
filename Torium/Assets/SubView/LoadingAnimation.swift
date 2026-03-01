//
//  LoadingAnimationView.swift
//  Torium
//
//  Created by 최진모 on 2/22/26.
//
import SwiftUI

struct LoadingAnimationView: View {
    @Binding var phase: SplashFeature.AnimationPhase
    
    @State private var sweepStart: CGFloat = 0
    @State private var sweepEnd: CGFloat = 0
    @State private var rotation: CGFloat = 0
    @State private var showTail: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: sweepStart, to: sweepEnd)
                .stroke(
                    Color.Brand,
                    style: StrokeStyle(lineWidth: 30, lineCap: .butt)
                )
                .frame(width: 70, height: 70)
                .rotationEffect(.degrees(180))
            
            if showTail {
                Circle()
                    .trim(from: (180-15)/360, to: (180+15)/360)
                    .stroke(
                        Color.Brand,
                        style: StrokeStyle(lineWidth: 30, lineCap: .butt)
                    )
                    .frame(width: 70, height: 70)
                    .rotationEffect(.degrees(180 + rotation))
            }
        }
        .onAppear {
            startAnimation()
        }
        .onChange(of: phase) {
            if phase == .open {
                startAnimation()
            } else if phase == .close {
                closeAnimation()
            }
        }
    }
    
    private func startAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            sweepEnd = (180+15)/360
        } completion: {
            sweepEnd = (180-15)/360
            showTail = true

            withAnimation(.easeInOut(duration: 0.5)) {
                rotation = 90-15
            } completion: {
                phase = .stop
            }
        }
    }
    
    private func closeAnimation() {
        withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
            rotation = 180+15
        } completion: {
            showTail = false
            withAnimation(.easeInOut(duration: 0.5)) {
                sweepStart = (180-15)/360
            } completion: {
                sweepStart = 0
                sweepEnd = 0
                rotation = 0
                showTail = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    phase = .open
                }
            }
        }
    }
}
