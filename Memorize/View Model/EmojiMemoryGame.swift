//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/7/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let themes: [String : Theme<String> ] = [
    
        "vehicles" : Theme(themeTitle: "Vehicles", themeContents: ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"], cardColor: "red", numberOfPairs: 8),
        
        "animals" : Theme(themeTitle: "Animals", themeContents: ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"], cardColor: "green", numberOfPairs: 16),
        
        "faces" : Theme(themeTitle: "Faces", themeContents: ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"], cardColor: "yellow", numberOfPairs: 10),
        
        "flags" : Theme(themeTitle: "Flags", themeContents: ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇺🇸", "🇬🇧", "🇯🇵", "🇩🇰", "🇰🇷"], cardColor: "blue", numberOfPairs: 10),
        
        "zodiacs" : Theme(themeTitle: "Zodiacs", themeContents: ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"], cardColor: "purple", numberOfPairs: 12),
        
        "random" : Theme(themeTitle: "Random", themeContents: ["🥨", "🛁", "📚", "🃏", "🧸", "🖥", "🚀", "🏕", "🏆", "🫧"], cardColor: "gray", numberOfPairs: 6)
    ]

    
    static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        let randomizedThemeArray = theme.themeContents.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
           randomizedThemeArray[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
     var currentTheme = themes["flags"]!
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func randomThemeChooser() -> Theme<String> {
        
        var keyArray : [String] = []
        for key in EmojiMemoryGame.themes.keys {
            keyArray.append(key)
        }
        let randomKey = keyArray.randomElement() ?? "vehicles"
        currentTheme = EmojiMemoryGame.themes[randomKey]!
        return EmojiMemoryGame.themes[randomKey]!
        
    }
    
    func resetGame() {
        let randomTheme = randomThemeChooser()
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
    }
    
    func chooseTheme(named theme: String) {
        
        let chosenTheme = EmojiMemoryGame.themes[theme]!
        self.model = EmojiMemoryGame.createMemoryGame(with: chosenTheme)
        
    }
}



