//
//  Theme.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/13/22.
//

import Foundation
import SwiftUI

struct Theme<ContentItems> {
    
    var themeTitle: String
    var themeContents: [ContentItems]
    var cardColor: Color
    var numberOfPairs: Int
}
