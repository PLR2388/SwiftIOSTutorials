//
//  CardView.swift
//  Flashzilla
//
//  Created by Paul-Louis Renard on 26/01/2023.
//

import SwiftUI

extension Shape {
    func fillCorrectly(offset: CGSize) -> some View {
        let color: Color
        if offset.width > 0 {
            color = .green
        } else if offset.width < 0 {
            color = .red
        } else {
            color = .white
        }
        return self.fill(color)
    }
}

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fillCorrectly(offset: offset)
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
       
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                print(offset.width)
                feedback.prepare() // Prepare haptic to happen at the right time
            }
            .onEnded{ _ in
                print(offset.width)
                if abs(offset.width) > 100 {
                   // remove the card
                    if offset.width < 0 {
                        // just play for error not everyTime
                        feedback.notificationOccurred(.error)
                    }
                    
                    removal?()
                } else {
                    withAnimation {
                        offset = .zero
                    }
                    print(offset.width)
                    
                }
            })
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
