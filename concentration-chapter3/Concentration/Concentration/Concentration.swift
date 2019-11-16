//
//  Concentration.swift
//  Concentration
//
//  Created by 明明很帅 on 2019/11/15.
//  Copyright © 2019 明明很帅. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var numberOfPairOfCards = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIdx = indexOfOneAndOnlyFaceUpCard, index != indexOfOneAndOnlyFaceUpCard {
                if cards[matchIdx].identifier == cards[index].identifier {
                    cards[matchIdx].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIdx in cards.indices {
                    cards[flipDownIdx].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isFaceUp = true
            }
        }
    }
    
    //作业，重新开始逻辑
    func restart() {
        start(numberOfPairOfCards: self.numberOfPairOfCards)
    }
    
    func start(numberOfPairOfCards: Int) {
        cards.removeAll()
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //作业部分，洗牌
        var cardsTemp = [Card]()
        while cards.count > 0 {
            let randomIdx = Int(arc4random_uniform(UInt32(cards.count)))
            cardsTemp.append(cards.remove(at: randomIdx))
        }
        cards = cardsTemp
    }
    
    init(numberOfPairOfCards: Int) {
        self.numberOfPairOfCards = numberOfPairOfCards
        start(numberOfPairOfCards: self.numberOfPairOfCards)
    }
}
