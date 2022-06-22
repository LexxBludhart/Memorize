//
//  ContentView.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        
        VStack {
            Text ("Theme Name")
                .font(.largeTitle)
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
                Text ("SCORE:")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
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
            viewModel.resetGame()
        } label: {
            Image(systemName: "repeat")
                .font(.largeTitle)
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
                    Text(card.content).font(.largeTitle)
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


