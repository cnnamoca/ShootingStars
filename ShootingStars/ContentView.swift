//
//  ContentView.swift
//  ShootingStars
//
//  Created by Carlo Namoca on 2024-05-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .blur(radius: 5)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                .overlay {
                    ShootingStarView()
                        .mask {
                            Circle()
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        }
                }
        }
    }
}

struct ShootingStarView: View {
    @State private var offsetX: CGFloat = -UIScreen.main.bounds.width
    @State private var scale: CGFloat = 0.5
    @State private var isVisible = true
    
    var body: some View {
        VStack {
            Spacer()
            
            if isVisible {
                Image("star")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .offset(x: offsetX - 10)
                    .scaleEffect(CGFloat(Float.random(in: 0.3..<0.5)))
                    .onAppear {
                        startAnimation()
                    }
                Image("star")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .offset(x: offsetX)
                    .scaleEffect(CGFloat(Float.random(in: 1.3..<1.8)))
                    .onAppear {
                        startAnimation()
                    }
                Image("star")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .offset(x: offsetX - 20)
                    .scaleEffect(CGFloat(Float.random(in: 0.5..<1.2)))
                    .onAppear {
                        startAnimation()
                    }
            }
            
            
            Spacer()
        }
    }
    
    private func startAnimation() {
        let screenWidth = UIScreen.main.bounds.width

        // First part of the animation: move to the center and scale up
        withAnimation(Animation.linear(duration: 0.5)) {
            offsetX = 0
//            scale = 1.0
        }
        
        // After the first part, move to the end and scale down
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: 0.2)) {
                offsetX = screenWidth * 2
//                scale = 0
            }
        }
        
        // Reset the circle after the animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isVisible = false
            offsetX = -screenWidth
//            scale = CGFloat(Float.random(in: 0.3...0.5))
            
            // Show the circle again and restart the animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isVisible = true
                startAnimation()
            }
        }
    }
}

#Preview {
    ContentView()
}
