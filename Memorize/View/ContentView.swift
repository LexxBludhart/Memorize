//
//  ContentView.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var isAnimated = false
    
    var body: some View {
        
        VStack {
            Text ("\(viewModel.currentThemeName)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(viewModel.currentTheme.cardColor.stringToColor())
                .grayscale(0.6)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))] ) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.currentTheme.cardColor.stringToColor())
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                resetButton
                Spacer()
                Text ("SCORE: \(viewModel.currentScore)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.currentTheme.cardColor.stringToColor())
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
            AudioManager.instance.playAudio(sound: AudioManager.SoundOption.swoosh)
            viewModel.resetGame()
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
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
    }
}


