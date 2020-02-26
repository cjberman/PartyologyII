//
//  Deck.swift
//  PartyologyII
//
//  Created by Alexander Levinson (student LM) on 2/25/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import Foundation

class Deck{

    private var cards = [FlashCard]()
    
    init(){
        let cardData = ["Big Chungus" : "Refers to an image of the cartoon character Bugs Bunny, usually presented as a game for a PlayStation 4 console.", "Epic Fail" : "a spectacularly embarrassing or humorous mistake, humiliating situation, etc., that is subject to ridicule and given a greatly exaggerated importance. "]
    
        for (term, definition) in cardData {
            cards.append(FlashCard(term, definition: definition))
        }
        
    }
    
    func getCard() -> FlashCard?{
        return (cards.isEmpty) ?  nil : cards[Int.random(in: 0..<cards.count)]
    }
    
}
