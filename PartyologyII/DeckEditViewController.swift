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
    let dict = ["Term1": "Definition1", "Term2": "Definition2", "Term3": "Definiton3"]
    var deckDisplay = UITextView()
    
    func setUpDeckDisplay(){
        view.addSubview(deckDisplay)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        addDeck(name: "Test Deck", dictionary: dict)
    }
    
    func addDeck(name: String, dictionary: Dictionary<String, String>){
        ref?.child("User").child("Decks").child(name).setValue(dictionary)
    }


}
