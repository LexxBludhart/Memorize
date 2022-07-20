//
//  ThemeStore.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/20/22.
//

import Foundation
import SwiftUI

class ThemeStore: ObservableObject {
    
//    let name: String
    
    static let themes: [String : Theme<String> ] = [
        
        "vehicles" : Theme(themeTitle: "Vehicles", themeContents: ["🚗", "🚙", "🏎", "🛻", "🚜", "🚌", "🚐", "🚛"], cardColor: "red", numberOfPairs: 20),
        
        "animals" : Theme(themeTitle: "Animals", themeContents: ["🦎", "🐸", "🐍", "🦜", "🦄", "🦖", "🦕", "🐊", "🦤", "🦆", "🐧", "🐣", "🦨", "🐢", "🐙", "🦑", "🦭", "🦦", "🦥", "🦔", "🐷", "🐉", "🐓", "🪱"], cardColor: "green", numberOfPairs: 24),
        
        "faces" : Theme(themeTitle: "Faces", themeContents: ["🙂", "😄", "😎", "😋", "👽", "🥰", "🥸", "😇", "🥳", "😱", "🤠", "💩", "🥴", "😵", "🫥", "😑"], cardColor: "yellow", numberOfPairs: 14),
        
        "flags" : Theme(themeTitle: "Flags", themeContents: ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇺🇸", "🇬🇧", "🇯🇵", "🇩🇰", "🇰🇷"], cardColor: "blue", numberOfPairs: 16),
        
        "zodiacs" : Theme(themeTitle: "Zodiacs", themeContents: ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"], cardColor: "purple", numberOfPairs: 12),
        
        "miscellaneous" : Theme(themeTitle: "Miscellaneous", themeContents: ["🥨", "🛁", "📚", "🃏", "🧸", "🖥", "🚀", "🏕", "🏆", "🫧"], cardColor: "gray", numberOfPairs: 14)
    ]
    
}


