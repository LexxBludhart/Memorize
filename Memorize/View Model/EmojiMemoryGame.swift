//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/7/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
//    static let instance = EmojiMemoryGame()
    
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var currentTheme = themes["vehicles"]!
    var currentThemeName =  "Vehicles"
    var score: Int {
        model.score
    }
    
    var gameFinsihed: Bool {
        currentNumberOfPairs == model.pairsMatched
    }
    lazy var currentNumberOfPairs = min(currentTheme.numberOfPairs, currentTheme.themeContents.count)
    
    static let themes: [String : Theme<String> ] = [
        
        "vehicles" : Theme(themeTitle: "Vehicles", themeContents: ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"], cardColor: "red", numberOfPairs: 20),
        
        "animals" : Theme(themeTitle: "Animals", themeContents: ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"], cardColor: "green", numberOfPairs: 24),
        
        "faces" : Theme(themeTitle: "Faces", themeContents: ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"], cardColor: "yellow", numberOfPairs: 14),
        
        "flags" : Theme(themeTitle: "Flags", themeContents: ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇺🇸", "🇬🇧", "🇯🇵", "🇩🇰", "🇰🇷"], cardColor: "blue", numberOfPairs: 16),
        
        "zodiacs" : Theme(themeTitle: "Zodiacs", themeContents: ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"], cardColor: "purple", numberOfPairs: 12),
        
        "miscellaneous" : Theme(themeTitle: "Miscellaneous", themeContents: ["🥨", "🛁", "📚", "🃏", "🧸", "🖥", "🚀", "🏕", "🏆", "🫧"], cardColor: "gray", numberOfPairs: 14)
    ]
    
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    
   
    
    static func createMemoryGame(with theme: Theme<String>) -> MemoryGame<String> {
        let randomizedThemeArray = theme.themeContents.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: min(theme.numberOfPairs, theme.themeContents.count)) { pairIndex in
            randomizedThemeArray[pairIndex]
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
        if model.pairsMatched == currentNumberOfPairs {
            gameFinishedAudio()
        }
    }
    
    func gameFinishedAudio() {
        if score > 0 {
            AudioManager.instance.playAudio(sound: .yayying)
        } else {
            AudioManager.instance.playAudio(sound: .suck)
        }
    }
    
    func randomThemeChooser() -> Theme<String> {
        
        var keyArray : [String] = []
        for key in EmojiMemoryGame.themes.keys {
            keyArray.append(key)
        }
        let randomKey = keyArray.randomElement() ?? "vehicles"
        currentTheme = EmojiMemoryGame.themes[randomKey]!
        currentThemeName = currentTheme.themeTitle
        return EmojiMemoryGame.themes[randomKey]!
        
    }
    
    func resetGame() {
        let randomTheme = randomThemeChooser()
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
        //      pairsMatched = 0
        //model.score = 0
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}




