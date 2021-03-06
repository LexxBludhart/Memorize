//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rhett Levitz on 6/7/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    // MARK: Variables/Constants
    
    private(set) var cards: Array<Card>
    
    var score = 0
    var pairsMatched = 0
    private let increasePairsMatched = 1
    private let matchPoint = 2
    private let matchPenalty = 1
    private let bonusPoint = 1
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter ({ cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    // MARK: Initializers

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        //add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    // MARK: Game Logic
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    pairsMatched += increasePairsMatched
                    AudioManager.instance.playAudio(sound: .ding)
                    score += matchPoint
                    if card.bonusTimeRemaining > 0 {
                        score += bonusPoint
                    }
                }
                else {
                    if cards[chosenIndex].hasBeenSeen {
                        AudioManager.instance.playAudio(sound: .fart)
                        score -= matchPenalty
                    }
                    else {
                        cards[chosenIndex].hasBeenSeen = true
                    }
                    if cards[potentialMatchIndex].hasBeenSeen {
                        AudioManager.instance.playAudio(sound: .fart)
                        score -= matchPenalty
                    }
                    else {
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // MARK: Card Logic
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        var hasBeenSeen = false
        

        
        // MARK: Bonus Time

       var bonusTimeLimit: TimeInterval = 3

       private var faceUpTime: TimeInterval {
           if let lastFaceUpDate = self.lastFaceUpDate {
               return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
           } else {
               return pastFaceUpTime
           }
       }

       var lastFaceUpDate: Date?

       var pastFaceUpTime: TimeInterval = 0

       var bonusTimeRemaining: TimeInterval {
           max(0, bonusTimeLimit - faceUpTime)
       }

       var bonusRemaining: Double {
           (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
       }

       var hasEarnedBonus: Bool {
           isMatched && bonusTimeRemaining > 0
       }

       var isConsumingBonusTime: Bool {
           isFaceUp && !isMatched && bonusTimeRemaining > 0
       }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}





