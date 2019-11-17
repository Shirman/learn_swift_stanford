//
//  Concentration.swift
//  Concentration
//
//  Created by 明明很帅 on 2019/11/15.
//  Copyright © 2019 明明很帅. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            //闭包使用
//            let faceUpIndices = cards.indices.filter({cards[$0].isFaceUp})
//            return faceUpIndices.count == 1 ? faceUpIndices[0] : nil
            
            // Collection 扩展
            return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
            
//            var foundIdx: Int?
//            for idx in cards.indices {
//                if cards[idx].isFaceUp{
//                    if foundIdx != nil {
//                        return nil
//                    } else {
//                        foundIdx = idx
//                    }
//                }
//            }
//            return foundIdx
        }
        
        set {
            for idx in cards.indices {
                cards[idx].isFaceUp = (idx == newValue)
            }
        }
    }
    
    private var numberOfPairOfCards = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chose index not in cards")
        if !cards[index].isMatched {
            if let matchIdx = indexOfOneAndOnlyFaceUpCard, index != indexOfOneAndOnlyFaceUpCard {
                if cards[matchIdx] == cards[index] {
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
    mutating func restart() {
        start(numberOfPairOfCards: self.numberOfPairOfCards)
    }
    
    mutating private func start(numberOfPairOfCards: Int) {
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

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
