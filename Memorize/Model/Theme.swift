//
//  Theme.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/13/22.
//

import Foundation

struct Theme<ContentItems> {
    
    var themeTitle: String
    var themeContents: [ContentItems]
    var cardColor: String
    var numberOfPairs: Int
}
