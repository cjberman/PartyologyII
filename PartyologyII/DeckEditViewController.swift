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

class DeckEditViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    //ui variables
    var addDeck = UIButton()
    let deckList: UITableView = {
           let tv = UITableView()
           tv.backgroundColor = UIColor.black
           tv.separatorColor = UIColor.white
           tv.translatesAutoresizingMaskIntoConstraints = false
           return tv
       }()
    
    //database variables
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var deckDecodable: DataData?

    //test dictionary
    let deck = Deck([FlashCard("Letter", "A"), FlashCard("Number", "10"), FlashCard("Space", "_"), FlashCard("Name", "Charlie"), FlashCard("App", "Partyology")], "Random Things")
    var decks: [Deck] = []
    var workingDeckName = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addDeckButton()
        setupDeckList()
        
        //creating refrence object
        ref = Database.database().reference()

        //adding the decks to the database
        addDeck(deck: deck)
        
        ref?.child("Decks").observeSingleEvent(of: .value, with: { (snapshot) in
            self.pullDeck(s: snapshot)
        })
        
    }
    
    //use to add a deck to the database (takes a deck parameter so make the deck first)
    func addDeck(deck: Deck){
        var dictionary = Dictionary<String, String>()
        decks.append(deck)
        
        //creates a dictionary of term:definition
        for i in deck.cards{
            dictionary[i.term] = i.definition
        }
        
        //updates database with the dictionary
        ref?.child("Decks").childByAutoId().child("Name").setValue(deck.name)
        
    }
    
    //pulls all the cards in a deck when updated (so if a change occurs to any deck, will reupdate I think), returns a deck
    func pullDeck(s: DataSnapshot){
        print(ref?.child("Decks").child(s.key as! String))
    }
        
   
    func addDeckButton(){
        //adding to view
        view.addSubview(addDeck)
        
        //setting up properties
        addDeck.setTitle("Add Deck", for: .normal)
        addDeck.setTitleColor(UIColor.lightGray, for: .normal)
        addDeck.backgroundColor = UIColor.blue
        addDeck.addTarget(self, action: #selector(addDeckSegue), for: .touchUpInside)
        addDeck.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        
        //constraints
        addDeck.translatesAutoresizingMaskIntoConstraints = false
        addDeck.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addDeck.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func addDeckSegue(){
        self.performSegue(withIdentifier: "toAddDeck", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deckList.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DeckCell
        // cell.backgroundColor = UIColor.white
        cell.deckLabel.text = "\(decks[indexPath.row].name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as? UITableViewCell
        
        if let cell = currentCell?.textLabel?.text{
            workingDeckName = cell
        }
        
        performSegue(withIdentifier: "toEditDeck", sender: self)
    }
    
    func setupDeckList() {
        //register is really important
        deckList.delegate = self
        deckList.dataSource = self
        deckList.register(DeckCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(deckList)
        
        //constraints
        NSLayoutConstraint.activate([
            deckList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            deckList.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            deckList.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            deckList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
}
