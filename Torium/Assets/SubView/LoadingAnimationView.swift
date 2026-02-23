//
//  LoadingAnimationView.swift
//  Torium
//
//  Created by 최진모 on 2/22/26.
//
import SwiftUI

struct LoadingAnimationView: View {
    var isLoading: Bool
    let completion: (() -> Void)?
    
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
            startAnimationCycle()
        }
    }
    
    private func startAnimationCycle() {
        // 1단계: 로고가 그려짐
        withAnimation(.easeInOut(duration: 0.5)) {
            sweepEnd = (180+15)/360
        } completion: {
            sweepEnd = (180-15)/360
            showTail = true
            
            // 2단계: 신호 확인 지점
            withAnimation(.easeInOut(duration: 0.5).delay(0.3)) {
                rotation = 90-15
            } completion: {
                checkPoint()
            }
        }
    }
    
    private func checkPoint() {
        if !isLoading {
            completion?()
        } else {
            continueAnimation()
        }
    }
    
    private func continueAnimation() {
        withAnimation(.easeIn(duration: 0.5).delay(0.8)) {
            rotation = 180+15
        } completion: {
            showTail = false
            withAnimation(.easeInOut(duration: 0.5)) {
                sweepStart = (180-15)/360
            } completion: {
                resetAndRestart()
            }
        }
    }
    
    private func resetAndRestart() {
        sweepStart = 0
        sweepEnd = 0
        rotation = 0
        showTail = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            startAnimationCycle()
        }
    }
}
