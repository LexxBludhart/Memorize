//
//  AudioManager.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/23/22.
//

import Foundation
import SwiftUI
import AVKit

class AudioManager {
    
    static let instance = AudioManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case swoosh
        case fart
        case noice
    }
    
    func playAudio(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
}

