//
//  EditDeckViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 4/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditDeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let editDeckName = UILabel()
    var masterDeck = Deck()
//    var officialDeck = Deck()
    var theOldName = ""
    let update = UIButton()
    let addCard = UIButton()
    var ref: DatabaseReference?
    var flashcardChosen = FlashCard()

    
    let deckList: UITableView = {
           let tv = UITableView()
           tv.backgroundColor = UIColor.black
           tv.separatorColor = UIColor.white
           tv.translatesAutoresizingMaskIntoConstraints = false
           return tv
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        officialDeck = masterDeck
        
        ref = Database.database().reference()
        
        print(theOldName)
        
        setUpDeckName()
        setupDeckLists()
        setUpButton()
        setUpButtonFlashcard()
    
    }
    
    func setUpDeckName(){
            //adding to view
        view.addSubview(editDeckName)
            
            //setting up properties
        editDeckName.text = masterDeck.name
        editDeckName.textColor = UIColor.black
        editDeckName.font = UIFont(name: "CourierNewPSMT", size: 30)
        editDeckName.adjustsFontSizeToFitWidth = true
    //        deckName.textFieldStyle(RoundedBorderTextFieldStyle())
                
            //constraints
            editDeckName.translatesAutoresizingMaskIntoConstraints = false
            editDeckName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
            editDeckName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        }
    
    func setUpButtonFlashcard(){
            //adding to view
        view.addSubview(addCard)
            
            //setting up properties
        addCard.setTitle("Add Card", for: .normal)
        addCard.setTitleColor(UIColor.lightGray, for: .normal)
        addCard.backgroundColor = UIColor.purple
        addCard.addTarget(self, action: #selector(toEditNewCard), for: .touchUpInside)
        addCard.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        addCard.translatesAutoresizingMaskIntoConstraints = false
        addCard.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        addCard.centerYAnchor.constraint(equalTo: deckList.bottomAnchor, constant: 100).isActive = true
        }
    
    func setUpButton(){
            //adding to view
        view.addSubview(update)
            
            //setting up properties
        update.setTitle("Update", for: .normal)
        update.setTitleColor(UIColor.lightGray, for: .normal)
        update.backgroundColor = UIColor.blue
        update.addTarget(self, action: #selector(updateDeck), for: .touchUpInside)
        update.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        update.translatesAutoresizingMaskIntoConstraints = false
        update.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        update.centerYAnchor.constraint(equalTo: deckList.bottomAnchor, constant: 100).isActive = true
        }
        
    @objc func toEditNewCard(){
        self.performSegue(withIdentifier: "toEditNewCard", sender: self)
    }
    
    @objc func updateDeck(){
       addDeck(deck: masterDeck)
        
        self.performSegue(withIdentifier: "backToDeckEdit", sender: self)
    }
    
    
    func setupDeckLists() {
        //register is really important
        deckList.delegate = self
        deckList.dataSource = self
        deckList.register(DeckCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(deckList)
        
        //constraints
        NSLayoutConstraint.activate([
            deckList.topAnchor.constraint(equalTo: self.editDeckName.topAnchor, constant: 50),
            deckList.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            deckList.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            deckList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = deckList.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DeckCell
             // cell.backgroundColor = UIColor.white
        cell.deckLabel.text = "\(masterDeck.cards[indexPath.row].term): \(masterDeck.cards[indexPath.row].definition)"
        cell.deckLabel.adjustsFontSizeToFitWidth = true
             
             return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return masterDeck.cards.count
       }
    
    //code that runs when a cell is clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as? DeckCell
        
        //finds deck that corresponds with label
        if let cell = currentCell?.deckLabel.text{
            for i in masterDeck.cards{
                if cell == "\(i.term): \(i.definition)"{
                    flashcardChosen = i
                }
            }
        }
        
        //goes to EditDeck
        performSegue(withIdentifier: "toEditFlashcard", sender: self)
    }
    
    //sends the deck clicked on over to the EditDeckView Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditFlashcard" {
            let controller = segue.destination as! EditFlashcardViewController
            controller.masterFlashcard = flashcardChosen
            controller.theDeckOfTruth = masterDeck
        }
        else  if segue.identifier == "toEditNewCard" {
            let controller = segue.destination as! EditNewFlashcardViewController
            controller.theOneDeckToRuleThemAll = masterDeck
        }
    }

    
    
    
    
    
    //use to add a deck to the database (takes a deck parameter so make the deck first)
    func addDeck(deck: Deck){
        //creates a dictionary of term:definition
        for i in 0..<deck.cards.count{ ref?.child("Decks").child(deck.name).child("Cards").child("\(i)").child("Term").setValue(deck.cards[i].term)
            
            print("No error for giving term")
        ref?.child("Decks").child(deck.name).child("Cards").child("\(i)").child("Definition").setValue(deck.cards[i].definition)
            
            print("No error for giving definition")
        }

        
    }
}
