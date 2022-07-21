//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/20/22.
//

import SwiftUI

struct ThemeChooser: View {
    
    @EnvironmentObject var store: ThemeStore
    
    var body: some View {
        themeMenuButton
    }
    
    var themeMenuButton: some View {
        Button {
            AudioManager.instance.playAudio(sound: .iphoneMessage)
        } label: {
            Image(systemName: "square.on.square")
                .font(.largeTitle)
        }
        .contextMenu { contextMenu }
    }
    
    @ViewBuilder
    var contextMenu: some View {
        AnimatedActionButton(title: "Edit", systemImage: "pencil") {
//            paletteToEdit = store.palette(at: chosenpaletteIndex)
        }
        AnimatedActionButton(title: "New", systemImage: "plus") {
//            store.insertPalette(named: "New", emojis: "", at: chosenpaletteIndex)
//            paletteToEdit = store.palette(at: chosenpaletteIndex)
        }
        AnimatedActionButton(title: "Delete", systemImage: "minus.circle") {
//            chosenpaletteIndex = store.removePalette(at: chosenpaletteIndex)
        }
        AnimatedActionButton(title: "Manager", systemImage: "slider.vertical.3") {
//            managing = true
        }
        gotoMenu
    }

    var gotoMenu: some View {
        Menu {
//            ForEach (store.palettes) { palette in
//                AnimatedActionButton(title: palette.name) {
//                    if let index = store.palettes.index(matching: palette) {
//                        chosenpaletteIndex = index
//                    }
//                }
//            }
        } label: {
            Label("Go To", systemImage: "text.insert")
        }
    }
    
    
}








struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
