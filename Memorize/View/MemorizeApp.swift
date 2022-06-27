//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/1/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
