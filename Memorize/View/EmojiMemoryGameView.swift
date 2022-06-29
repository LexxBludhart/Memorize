//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/1/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    @State var isAnimated = false
    
    var body: some View {
        
        VStack {
            title
            gameBody
                .padding(.horizontal)
            
            HStack {
                Spacer()
                resetButton
                Spacer()
                scoreTitle
                Spacer()
                shuffleButton
                Spacer()
            }
            .padding(.top, 20)
            Spacer()
        }
    }
    
    var title: some View {
        Text ("\(game.currentThemeName)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(game.currentTheme.cardColor.stringToColor())
            .grayscale(DrawingConstants.grayScale)
    }
    
    var scoreTitle: some View {
        Text ("SCORE: \(game.score)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(game.currentTheme.cardColor.stringToColor())
            .grayscale(DrawingConstants.grayScale)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card, color: game.currentTheme.cardColor.stringToColor())
                    .padding(5)
                    .onTapGesture {
                        AudioManager.instance.playAudio(sound: .paperFlip)
                        game.choose(card)
                    }
            }
        }
    }
    
    var resetButton: some View {
        
        Button {
            AudioManager.instance.playAudio(sound: .woosh)
            withAnimation(Animation.easeInOut) {
                game.resetGame()
            }
            withAnimation(
                Animation
                    .default
                    .repeatCount(1, autoreverses: false)
            ) {
                isAnimated.toggle()
            }
        } label: {
            Image(systemName: "repeat")
                .font(.largeTitle)
                .rotationEffect(Angle(degrees: isAnimated ? 360: 0))
        }
    }
    
    var shuffleButton: some View {
        
        Button {
            withAnimation {
                game.shuffle()
            }
        } label: {
            Image(systemName: "shuffle")
                .font(.largeTitle)
        }
    }
    
    struct CardView: View {
        let card: MemoryGame<String>.Card
        let color: Color
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                        .padding(6)
                        .opacity(DrawingConstants.opacity)
                        .foregroundColor(color)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.easeInOut(duration: 1))
                        .font(.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .foregroundColor(color)
                .grayscale(0.1)
            }
        }
        
        private func scale(thatFits size: CGSize) -> CGFloat {
            min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
        }
        
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
        static let grayScale: CGFloat = 0.6
        static let opacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
            EmojiMemoryGameView(game: game)
        }
    }
}

