//
//  DeckEditViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

struct DeckOption: Decodable, Encodable {
    var name: String
    var cards: [FlashCard]
}

struct DeckList: Decodable, Encodable {
    var decks: [DeckOption]
}

struct DataData: Decodable, Encodable {
    var data: DeckList
}

class DeckEditViewController: UIViewController {
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var deckDecodable: DataData?
    

    //test dictionary
    let deck = Deck([FlashCard("Letter", "A"), FlashCard("Number", "10"), FlashCard("Space", "_"), FlashCard("Name", "Charlie"), FlashCard("App", "Partyology")], "Random Things")
    var decks = [Deck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating refrence object
        ref = Database.database().reference()

        //adding the decks to the database
        addDeck(deck: deck)
        
        pullDeck()
        
    }
    
    //use to add a deck to the database (takes a deck parameter so make the deck first)
    func addDeck(deck: Deck){
        var dictionary = Dictionary<String, String>()
        var decks: [Deck] = []
        
        decks.append(deck)
        
        //creates a dictionary of term:definition
        for i in deck.cards{
            dictionary[i.term] = i.definition
        }
        
        for i in deck.cards{
            dictionary[i.term] = i.definition
        }
        
        //updates database with the dictionary
        ref?.child("Decks").child(deck.name).setValue(dictionary)
        
    }
    
    //pulls all the cards in a deck when updated (so if a change occurs to any deck, will reupdate I think), returns a deck
    func pullDeck(){
        let jsonURLString = "https://partyologyii.firebaseio.com/"
               
        guard let url = URL(string: jsonURLString) else {return}
        
        print("Entering pullDeck function")
        //Use the URLSession singleton to perform a dataTask. After dataTask gets the informaton from our URL, it will call the closure, passing it data, response, err. .resume() starts our dataTask
        URLSession.shared.dataTask(with: url) { (data, response, err) in
        guard let data = data else {return}

             print("Made it into URLSession")
            
            do{
                self.deckDecodable = try JSONDecoder().decode(DataData.self, from: data)
                print(self.deckDecodable as Any)
                print("Made it into do part")
                DispatchQueue.main.async {
                    print("ASYNC")
                }
            }catch let jsonErr{
                print(jsonErr)
                print("do part failed")
            }
            }.resume()
    }
    
    



}

