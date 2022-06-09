//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/7/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
     static var emojis = ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"]
    
    let themes = [
    
        "vehicles" : ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"],
        "animals" : ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"],
        "faces" : ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"],
        "flags" : ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇺🇸", "🇬🇧", "🇯🇵", "🇩🇰", "🇰🇷"],
        "zodiacs" : ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"],
        "random" : ["🥨", "🛁", "📚", "🃏", "🧸", "🖥", "🚀", "🏕", "🏆", "🫧"]
    ]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    func changeTheme(to theme: String) {
        switch theme {
        case "animals": EmojiMemoryGame.emojis = EmojiMemoryGame.animalEmojis
        case "faces": EmojiMemoryGame.emojis = EmojiMemoryGame.facesEmojis
        case "flags": EmojiMemoryGame.emojis = EmojiMemoryGame.flagsEmojis
        case "zodiacs": EmojiMemoryGame.emojis = EmojiMemoryGame.zodiacEmojis
        case "random": EmojiMemoryGame.emojis = EmojiMemoryGame.randomEmojis
        default: EmojiMemoryGame.emojis = EmojiMemoryGame.defaultEmojis
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
