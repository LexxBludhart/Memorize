//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/7/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let themes: [String : Theme<String> ] = [
    
        "vehicles" : Theme(themeTitle: "vehicles", themeContents: ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"], cardColor: .red, numberOfPairs: 8),
        
        "animals" : Theme(themeTitle: "animals", themeContents: ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"], cardColor: .green, numberOfPairs: 16),
        
        "faces" : Theme(themeTitle: "faces", themeContents: ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"], cardColor: .yellow, numberOfPairs: 10),
        
        "flags" : Theme(themeTitle: "flags", themeContents: ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇺🇸", "🇬🇧", "🇯🇵", "🇩🇰", "🇰🇷"], cardColor: .blue, numberOfPairs: 10),
        
        "zodiacs" : Theme(themeTitle: "zodiacs", themeContents: ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"], cardColor: .purple, numberOfPairs: 12),
        
        "random" : Theme(themeTitle: "random", themeContents: ["🥨", "🛁", "📚", "🃏", "🧸", "🖥", "🚀", "🏕", "🏆", "🫧"], cardColor: .black, numberOfPairs: 6)
    ]

    
    static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        let randomizedThemeArray = theme.themeContents.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
           randomizedThemeArray[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(with: randomThemeChooser())
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
   static func randomThemeChooser() -> Theme<String> {
        
        var keyArray : [String] = []
        for key in themes.keys {
            keyArray.append(key)
        }
        print(keyArray)
        let randomTheme = keyArray.randomElement() ?? "vehicles"
        print(randomTheme)
        
        return themes[randomTheme]!
        
    }
    
    func resetGame() {
        let randomTheme = EmojiMemoryGame.randomThemeChooser()
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
    }
}



