//
//  LoginTitleImage.swift
//  nfl-geofencing
//
//  Created by shiyo_ohashi on 2024/10/23.
//

import SwiftUI

struct LoginTitleImage: View {
    var onFinish: () -> Void
    @Binding var isLoginPushed: Bool
    @State private var isAnimating = false
    @State private var offsetY: CGFloat = -500
    @State private var offsetX: CGFloat = -700
    @State private var isBouncing = false
    @State private var isShaking = false
    @State private var shakeCount = 0
    
    var body: some View {
        if !isLoginPushed {
            Image("TitleIcon")
                .resizable()
                .transition(.scale(scale: 500, anchor: .init(x: 0.69, y: 0.48)))
                .aspectRatio(contentMode: .fit)
                .frame(width:  294,
                       height: 111)
                .offset(x: offsetX, y: offsetY)
                .rotationEffect(.degrees(isAnimating ? 5 : 0))
                .rotationEffect(.degrees(isShaking ? 12 : 0))
                .onAppear {
                    dropAnimation()
                }
                .onTapGesture {
                    withAnimation(Animation.default.repeatCount(3, autoreverses: true)) {
                        isShaking.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            isShaking = false
                        }
                    }
                }
        }
    }
    private func dropAnimation() {
        withAnimation(.easeIn(duration: 1.0)) {
            offsetY = 0
            offsetX = -50
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            bounceAnimation()
        }
    }
    
    private func bounceAnimation() {
        let bounceCount = 4
        for i in 0..<bounceCount {
            withAnimation(.interpolatingSpring(stiffness: 50,  damping: 5)) {
                if bounceCount == 0 {
                    offsetY -= 20
                    offsetX += 10
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {print("a")
                        withAnimation {
                            offsetY += 20
                            offsetX += 10
                        }
                    }
                } else if i == 1 {
                    offsetY -= 15
                    offsetX += 7
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            offsetY += 15
                            offsetX += 7
                        }
                    }
                }
                else{
                    offsetY -= 10
                    offsetX += 5
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            offsetY += 10
                            offsetX += 5
                        }
                    }
                    if i == bounceCount - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 0.3).delay(1)) {
                                isAnimating.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    LoginTitleImage(onFinish: {}, isLoginPushed: .constant(false))
}
