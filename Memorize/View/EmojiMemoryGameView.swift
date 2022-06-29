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
            Text ("\(game.currentThemeName)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(game.currentTheme.cardColor.stringToColor())
                .grayscale(DrawingConstants.grayScale)
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card, color: game.currentTheme.cardColor.stringToColor())
                        .padding(5)
                        .onTapGesture {
                            AudioManager.instance.playAudio(sound: .paperFlip)
                            game.choose(card)
                        }
                }
            }
            
            .padding(.horizontal)
            
            HStack {
                Spacer()
                resetButton
                Spacer()
                Text ("SCORE: \(game.score)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(game.currentTheme.cardColor.stringToColor())
                    .grayscale(DrawingConstants.grayScale)
                Spacer()
                themeMenu
                Spacer()
            }
            .padding(.top, 20)
            Spacer()
            
        }
    }
    
    var resetButton: some View {
        
        Button {
            AudioManager.instance.playAudio(sound: .woosh)
            game.resetGame()
            withAnimation(
                Animation
                    .default
                    .repeatCount(1, autoreverses: true)
            ) {
                isAnimated.toggle()
            }
        } label: {
            Image(systemName: "repeat")
                .font(.largeTitle)
                .rotationEffect(Angle(degrees: isAnimated ? 360: 0))
        }
    }
    
    var themeMenu: some View {
        
        Button {
            
        } label: {
            Image(systemName: "rectangle.on.rectangle")
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
                    Text(card.content).font(font(in: geometry.size))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .foregroundColor(color)
                .grayscale(0.1)
            }
        }
        
        private func font(in size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
        }
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
        static let grayScale: CGFloat = 0.6
        static let opacity: CGFloat = 0.5
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

