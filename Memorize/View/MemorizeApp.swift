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
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                EmojiMemoryGameView(game: game)
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.scale(scale: 7).animation(.easeOut(duration: 2.0)).combined(with: .opacity.animation(.easeOut(duration: 0.8))))
                }
            }
        }
    }
}
