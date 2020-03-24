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

struct CardOption: Decodable {
    var term: String
    var definition: String
}

class DeckEditViewController: UIViewController {
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var deckOption: DeckOption?
    var cardOption: CardOption?

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
        
        pullDeck(d: deck)

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
    func pullDeck(d: Deck){
        let jsonURLString = "https://partyologyii.firebaseio.com/Decks\(d.name)"
               
        guard let url = URL(string: jsonURLString) else {return}
        
        //Use the URLSession singleton to perform a dataTask. After dataTask gets the informaton from our URL, it will call the closure, passing it data, response, err. .resume() starts our dataTask
        URLSession.shared.dataTask(with: url) { (data, response, err) in
        guard let data = data else {return}

            do{
                self.deckOption = try JSONDecoder().decode(DeckOption.self, from: data)
                print(self.deckOption)
//                DispatchQueue.main.async {
//                    self.articleTableView.reloadData()
//                }
            }catch let jsonErr{
                print(jsonErr)
            }
            }.resume()
    }
    
    



}
