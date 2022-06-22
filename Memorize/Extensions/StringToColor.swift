//
//  StringToColor.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/22/22.
//

import Foundation
import SwiftUI

extension String {
    func stringToColor() -> Color {
        switch self {
        case "red" : return Color.red
        case "blue" : return Color.blue
        case "green" : return Color.green
        case "purple" : return Color.purple
        case "yellow" : return Color.yellow
        case "gray" : return Color.gray
        default : return Color.pink
        }
    }
}
