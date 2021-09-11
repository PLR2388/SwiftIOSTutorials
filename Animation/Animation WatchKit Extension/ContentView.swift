//
//  ContentView.swift
//  Animation WatchKit Extension
//
//  Created by Paul-Louis Renard on 11/09/2021.
//

import SwiftUI

struct ContentView: View {
    //@State private var animationAmount: CGFloat = 1 // example 1 and 2
    @State private var animationAmount = 0.0 // exameple 3
    @State private var isShowingRed = false
    
    var body: some View {
        
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Color.red
                    .frame(width: 100, height: 100)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity)) // Choose different animation for appearing and disappearing
                    //.transition(.scale) // take more space animation onAppear and less on Disappear
            }

        }
        
        // THIRD EXAMPLE
        
//        Button("Tap Me") {
//            // do nothing
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                animationAmount += 360
//            }
//        }
//        .buttonStyle(PlainButtonStyle())
//        .padding(40)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(
//            .degrees(animationAmount),
//            axis: (x: 0.0, y: 1.0, z: 0.0)
//        )
        
        
        // SECOND EXAMPLE
        
//        print(animationAmount)
//
//        return VStack {
//            Slider(value: $animationAmount.animation(Animation.easeInOut(duration: 1).repeatCount(3,autoreverses: true)), in: 1...2, step: 0.2)
//
//            Spacer()
//
//            Button("Tap Me") {
//                animationAmount = 1
//            }
//            .buttonStyle(PlainButtonStyle())
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
        
        
        // FIRST EXAMPLE
        
//        Button("Tap Me"){
//      //      animationAmount += 0.25
//        }
//        .buttonStyle(PlainButtonStyle())
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
////        .scaleEffect(animationAmount)
////        .blur(radius: (animationAmount - 1) * 3)
//        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
//        //.animation(Animation.easeInOut(duration: 1).repeatCount(3, autoreverses: true))
////        .animation(Animation.easeOut(duration: 2).delay(1))
//        //.animation(.interpolatingSpring(stiffness: 50, damping: 1))
//        .overlay(Circle()
//                    .strokeBorder(Color.red)
//                    .scaleEffect(animationAmount)
//                    .opacity(Double(2-animationAmount))
//                    .animation(Animation.easeOut(duration: 1)
//                                .repeatForever(autoreverses: false))
//        )
//        .onAppear {
//            animationAmount = 2
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
