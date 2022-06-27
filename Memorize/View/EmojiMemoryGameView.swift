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
                .grayscale(0.6)
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
                    .grayscale(0.6)
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
                    .repeatCount(2, autoreverses: true)
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
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 15.0)
                if card.isFaceUp {
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: 4)
                        .foregroundColor(color)
                        .grayscale(0.6)
                    Text(card.content)
                        .font(.largeTitle)
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill(color)
                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
    }
}


