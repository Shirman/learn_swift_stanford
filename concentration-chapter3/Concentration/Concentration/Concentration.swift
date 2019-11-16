//
//  Concentration.swift
//  Concentration
//
//  Created by 明明很帅 on 2019/11/15.
//  Copyright © 2019 明明很帅. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIdx: Int?
            for idx in cards.indices {
                if cards[idx].isFaceUp{
                    if foundIdx != nil {
                        return nil
                    } else {
                        foundIdx = idx
                    }
                }
            }
            return foundIdx
        }
        
        set {
            for idx in cards.indices {
                cards[idx].isFaceUp = (idx == newValue)
            }
        }
    }
    
    private var numberOfPairOfCards = 0
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chose index not in cards")
        if !cards[index].isMatched {
            if let matchIdx = indexOfOneAndOnlyFaceUpCard, index != indexOfOneAndOnlyFaceUpCard {
                if cards[matchIdx].identifier == cards[index].identifier {
                    cards[matchIdx].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //作业，重新开始逻辑
    func restart() {
        start(numberOfPairOfCards: self.numberOfPairOfCards)
    }
    
    private func start(numberOfPairOfCards: Int) {
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
        assert(numberOfPairOfCards > 0, "Concentration.init(anumberOfPairOfCardst: \(numberOfPairOfCards)): you must have at least one pair of cards")
        self.numberOfPairOfCards = numberOfPairOfCards
        start(numberOfPairOfCards: self.numberOfPairOfCards)
    }
}
