//
//  Deck.swift
//  PartyologyII
//
//  Created by Alexander Levinson (student LM) on 2/25/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import Foundation

class Deck{

    public var cards = [FlashCard]()
    public var name = String()

    init(_ c: [FlashCard], _ n: String) {
        cards = c
        name = n
    }
    
    init(){
        cards = [FlashCard]()
        name = "Default Name"
    }
    
    func getRandomCard() -> FlashCard?{
        return (cards.isEmpty) ?  nil : cards[Int.random(in: 0..<cards.count)]
    }
    
    
    func getQuickDeck(num: Int) -> Deck{
        let quickDeck = Deck()
        let card = FlashCard()
        
        for _ in 0..<num{
            card.term = "Numbers"
            card.definition = String(Int.random(in: 0..<num))
            quickDeck.cards.append(card)
        }
        
        return quickDeck
    }
    
}
