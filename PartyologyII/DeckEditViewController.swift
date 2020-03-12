//
//  DeckEditViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

struct DeckOption: Decodable {
    var name: String
    var cards: [FlashCard]
}

class DeckEditViewController: UIViewController {
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    

    //test dictionary
    let deck = Deck([FlashCard("Letter", "A"), FlashCard("Number", "10"), FlashCard("Space", "_"), FlashCard("Name", "Charlie"), FlashCard("App", "Partyology")], "Random Things")
    var decks = [Deck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating refrence object
        ref = Database.database().reference()

        //adding the decks to the database
        addDeck(deck: deck)
       
        //test to print all the flashcards in a deck
//        for i in pullDeck().cards{
//            print(i.description)
//        }
        
        pullDeck()

    }
    
    //use to add a deck to the database (takes a deck parameter so make the deck first)
    func addDeck(deck: Deck){
        var dictionary = Dictionary<String, String>()
        
        //creates a dictionary of term:definition
        for i in deck.cards{
            dictionary[i.term] = i.definition
        }
        
        //updates database with the dictionary
        ref?.child("Decks").child("Deck").setValue(dictionary)
        
        //appends the made deck to an array of decks
        //not sure if I use this but that's what the line does
        decks.append(deck)
    }
    
    //pulls all the cards in a deck when updated (so if a change occurs to any deck, will reupdate I think), returns a deck
    func pullDeck() -> Deck {
        let flashcard = FlashCard()
        var newDeck = Deck()
          
        //if a child node in parent node "Decks" changes, reupdate everything
        ref?.child("Decks").observeSingleEvent(of: .value, with: {snapshot in
           //sets 'newDeck' name to name of deck
            
            let t = snapshot.value
            print(t!)
//            if let name = self.ref?.child("Decks").key{
//                newDeck.name = name
//            }
//
//            //sets term as snapshot key
//            flashcard.term = snapshot.key
//
//            //sets constant definition as snapshot value
//            let definition = snapshot.value as? String
//
//            //sets flashcard.definition to constant definition if exists
//            if let actualDefinition = definition{
//                flashcard.definition = actualDefinition
//            }
//
//            newDeck.cards.append(flashcard)
        })
        return newDeck
    }
    
    


}
