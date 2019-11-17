//
//  ViewController.swift
//  Concentration
//
//  Created by 明明很帅 on 2019/11/14.
//  Copyright © 2019 明明很帅. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipLabel()
        }
    }
    
    private func updateFlipLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
                    .strokeWidth : 5.0,
                    .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                ]
        let attributeString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributeString
    }
    
//    @IBAction func restartButton(_ sender: UIButton) {
//        game.restart()
//        flipCount = 0
//        updateViewFromModel()
//    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
//    private var emojiChoices = ["👻", "🎃", "💀", "👺", "🙀", "😍", "💩", "👾", "🤡", "🐷", "🐸", "🐰"]
    
    private var emojiChoices = "👻🎃💀👺🙀😍💩👾🤡🐷🐸🐰"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            //use my Int extension arc4random
//            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            let randomStringIdx = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.indices.count.arc4random)
            emoji[card] = String (emojiChoices.remove(at: randomStringIdx))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

//枚举
enum YesOrNo {
    case Yes
    case No
}
