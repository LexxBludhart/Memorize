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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))] ) {
                    ForEach(game.cards) { card in
                        CardView(card: card, color: game.currentTheme.cardColor.stringToColor())
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                AudioManager.instance.playAudio(sound: .paperFlip)
                                game.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                resetButton
                Spacer()
                Text ("SCORE: \(game.currentScore)")
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
                    let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    if card.isFaceUp {
                        shape.fill(.white)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                            .foregroundColor(color)
                            .grayscale(DrawingConstants.grayScale)
                        Text(card.content).font(font(in: geometry.size))
                    } else if card.isMatched {
                        shape.opacity(0)
                    } else {
                        shape.fill(color)
                            .grayscale(0.1)
                    }
                }
            }
        }
        
        private func font(in size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 4
        static let fontScale: CGFloat = 0.8
        static let grayScale: CGFloat = 0.6
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
