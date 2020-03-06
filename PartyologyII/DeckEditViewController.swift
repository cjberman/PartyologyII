//
//  DeckEditViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class DeckEditViewController: UIViewController {
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?

    //test dictionary
    let deck = Deck(c: [FlashCard("Letter", "A"), FlashCard("Number", "10"), FlashCard("Space", "_")], n: "Random Things")
    var newDeck = Deck()
    var deckDisplay = UITextView()
    var decks = [Deck]()
    
    func setUpDeckDisplay(){
        view.addSubview(deckDisplay)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating refrence object
        ref = Database.database().reference()

        //adding the decks to the database
        addDeck(deck: deck)

       
        
        //attempting to retrieve data
        for i in 0..<deck.cards.count{
            let snapshot = ref?.child("Decks").child(deck.name).child(deck.cards[i].term)

            guard let term = snapshot?.key else {return}
            guard let definition = snapshot?.queryEqual(toValue: deck.cards[i].definition, childKey: term) else {return}
            print(definition)
            
        }

    }
    
    func addDeck(deck: Deck){
        var dictionary = Dictionary<String, String>()
        
        for i in deck.cards{
            dictionary[i.term] = i.definition
        }
        
        ref?.child("User").child("Decks").child(deck.name).setValue(dictionary)
        decks.append(deck)
    }
    
    func deckList() -> [Deck]{

        ref?.child("Decks").observe(.childAdded, with: { (snapshot) in
            let deck = snapshot.value
            print("\(deck)")
        })
        
        return decks
    }


}
