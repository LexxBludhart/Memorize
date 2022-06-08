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
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))] ) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
        
    }
//    var vehicleTheme: some View {
//        Button {
//            emojis = ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"]
//            emojiCount = emojis.count
//            emojis.shuffle()
//        } label: {
//            Image(systemName: "car")
//        }
//    }
//    var facesTheme: some View {
//        Button {
//            emojis = ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"]
//            emojiCount = emojis.count
//            emojis.shuffle()
//        } label: {
//            Image(systemName: "face.smiling")
//        }
//    }
//    var animalTheme: some View {
//        Button {
//            emojis = ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"]
//            emojiCount = emojis.count
//            emojis.shuffle()
//        } label: {
//            Image(systemName: "pawprint")
//        }
//    }

}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15.0)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 4)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill(.red)
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


