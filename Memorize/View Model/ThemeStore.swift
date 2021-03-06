//
//  ThemeStore.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/20/22.
//

import Foundation
import SwiftUI


class ThemeStore: ObservableObject {
    
    var currentTheme = themes["vehicles"]!
    var currentThemeName =  "Vehicles"
    
//    let name: String
    
    static let themes: [String : Theme<String> ] = [
        
        "vehicles" : Theme(themeTitle: "Vehicles", themeContents: ["π", "π", "π", "π»", "π", "π", "π", "π"], cardColor: "red", numberOfPairs: 20),
        
        "animals" : Theme(themeTitle: "Animals", themeContents: ["π¦", "πΈ", "π", "π¦", "π¦", "π¦", "π¦", "π", "π¦€", "π¦", "π§", "π£", "π¦¨", "π’", "π", "π¦", "π¦­", "π¦¦", "π¦₯", "π¦", "π·", "π", "π", "πͺ±"], cardColor: "green", numberOfPairs: 24),
        
        "faces" : Theme(themeTitle: "Faces", themeContents: ["π", "π", "π", "π", "π½", "π₯°", "π₯Έ", "π", "π₯³", "π±", "π€ ", "π©", "π₯΄", "π΅", "π«₯", "π"], cardColor: "yellow", numberOfPairs: 14),
        
        "flags" : Theme(themeTitle: "Flags", themeContents: ["π³οΈ", "π΄", "π΄ββ οΈ", "π", "π©", "πΊπΈ", "π¬π§", "π―π΅", "π©π°", "π°π·"], cardColor: "blue", numberOfPairs: 16),
        
        "zodiacs" : Theme(themeTitle: "Zodiacs", themeContents: ["βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ", "βοΈ"], cardColor: "purple", numberOfPairs: 12),
        
        "miscellaneous" : Theme(themeTitle: "Miscellaneous", themeContents: ["π₯¨", "π", "π", "π", "π§Έ", "π₯", "π", "π", "π", "π«§"], cardColor: "gray", numberOfPairs: 14)
    ]
    
}


