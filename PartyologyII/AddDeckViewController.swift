//

//  AddDeckViewController.swift

//  PartyologyII

//

//  Created by Charles Berman (student LM) on 4/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddDeckViewController: UIViewController {

    //Deck and flashcard variables
    var newDeck: Deck = Deck()
    var newCard: FlashCard = FlashCard()
    let devc = DeckEditViewController()
    
    //database variables
    
    var ref: DatabaseReference?
    
    var databaseHandle: DatabaseHandle?
    
    
    
    //ui variables
    
    var deckName = UITextField()
    
    var cardTerm = UITextField()
    
    var cardDefinition = UITextField()
    
    let addCard = UIButton()
    
    let deckComplete = UIButton()
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        ref = Database.database().reference()
        
        
        
        //UI Stuff
        
        setUpDeckName()
        
        setUpCardTerm()
        
        setUpCardDefition()
        
        setUpAddCard()
        
        setUpDeckComplete()
        
        
        
    }
    
    
    
    //use to add a deck to the database (takes a deck parameter so make the deck first)
    
    func addDeck(deck: Deck){
        
        //updates database with the dictionary
        
        ref?.child("Decks").child(deck.name).child("Cards")
        
        
        
        //creates a dictionary of term:definition
        
        for i in 0..<deck.cards.count{ ref?.child("Decks").child(deck.name).child("Cards").child("\(i)").child("Term").setValue(deck.cards[i].term)
            
            ref?.child("Decks").child(deck.name).child("Cards").child("\(i)").child("Definition").setValue(deck.cards[i].definition)
            
        }
        
        
        
    }
    
    
    
    func setUpDeckName(){
        
        //adding to view
        
        view.addSubview(deckName)
        
        
        
        //setting up properties
        
        deckName.placeholder = "Enter Deck Name"
        
        deckName.textColor = UIColor.lightGray
        
        deckName.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        deckName.adjustsFontSizeToFitWidth = true
        
        //        deckName.textFieldStyle(RoundedBorderTextFieldStyle())
        
        
        
        //constraints
        
        deckName.translatesAutoresizingMaskIntoConstraints = false
        
        deckName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        deckName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    
    
    func setUpCardTerm(){
        
        //adding to view
        
        view.addSubview(cardTerm)
        
        
        
        //setting up properties
        
        cardTerm.placeholder = "Term"
        
        cardTerm.textColor = UIColor.lightGray
        
        cardTerm.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        cardTerm.adjustsFontSizeToFitWidth = true
        
        //        cardTerm.textFieldStyle(RoundedBorderTextFieldStyle())
        
        
        
        //constraints
        
        cardTerm.translatesAutoresizingMaskIntoConstraints = false
        
        cardTerm.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        cardTerm.topAnchor.constraint(equalTo: deckName.bottomAnchor, constant: 150).isActive = true
    }
    
    func setUpCardDefition(){
        //adding to view
        view.addSubview(cardDefinition)
        
        //setting up properties
        cardDefinition.placeholder = "Definition"
        cardDefinition.textColor = UIColor.lightGray
        cardDefinition.font = UIFont(name: "CourierNewPSMT", size: 30)
        cardDefinition.adjustsFontSizeToFitWidth = true
//        cardDefinition.textFieldStyle(RoundedBorderTextFieldStyle())
            
        //constraints
        cardDefinition.translatesAutoresizingMaskIntoConstraints = false
        cardDefinition.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        cardDefinition.topAnchor.constraint(equalTo: cardTerm.bottomAnchor, constant: 50).isActive = true
    }
    
    func setUpAddCard(){
        //adding to view
        view.addSubview(addCard)
        
        //setting up properties
        addCard.setTitle("Add Card", for: .normal)
        addCard.setTitleColor(UIColor.lightGray, for: .normal)
        addCard.backgroundColor = UIColor.black
        addCard.addTarget(self, action: #selector(addCardSelector), for: .touchUpInside)
        addCard.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        addCard.translatesAutoresizingMaskIntoConstraints = false
        addCard.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addCard.centerYAnchor.constraint(equalTo: cardDefinition.bottomAnchor, constant: 50).isActive = true
    }
    
    @objc func addCardSelector(){
        
        var newCard = FlashCard()

        
        //setting term and definition
        if let termText = cardTerm.text, let termDefinition = cardDefinition.text{
            newCard.term = termText
            newCard.definition = termDefinition
        }
        
        print("\(newCard.term): \(newCard.definition)")
        
        //resetting text fields
        cardTerm.text = ""
        cardDefinition.text = ""
        cardTerm.placeholder = "Term"
        cardDefinition.placeholder = "Definition"
        
        //clearing the placeholder card and adding it to deck
        newDeck.cards.append(newCard)
        newCard.term = ""
        newCard.definition = ""
    }
    
    func setUpDeckComplete(){
        //adding to view
        view.addSubview(deckComplete)
        
        //setting up properties
        deckComplete.setTitle("Done", for: .normal)
        deckComplete.setTitleColor(UIColor.lightGray, for: .normal)
        deckComplete.backgroundColor = UIColor.black
        deckComplete.addTarget(self, action: #selector(deckCompleteSelector), for: .touchUpInside)
        deckComplete.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        deckComplete.translatesAutoresizingMaskIntoConstraints = false
        deckComplete.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        deckComplete.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func deckCompleteSelector(){
        if let deckNameText = deckName.text{
            newDeck.name = deckNameText
        }
        addDeck(deck: newDeck)
        devc.decks.append(newDeck)
        newDeck.name = ""
        newDeck.cards.removeAll()
        
        self.performSegue(withIdentifier: "returnToDeckEdit", sender: self)
    }
}
