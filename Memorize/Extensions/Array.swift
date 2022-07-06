//
//  Array.swift
//  Memorize
//
//  Created by Rhett Levitz on 7/6/22.
//

import Foundation


extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
