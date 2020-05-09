//
//  DeckEditViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase


class DeckEditViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    //ui variables
    var addDeckButton = UIButton()
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

    //test dictionary
    var workingDeck = Deck()
    var decks: [Deck] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAddDeckButton()
        
        
        //creating refrence object
        ref = Database.database().reference()

        //adding the decks to the database
//        addDeck(deck: deck)
        
        ref?.child("Decks").observe(.value, with: { (snapshot) in
            self.decks.removeAll()
            for i in self.pullDeck(s: snapshot){
                self.decks.append(i)
            }
            self.setupDeckList()
        })

        
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
    
    //pulls all the cards in a deck when updated (so if a change occurs to any deck, will reupdate I think), returns a deck
    func pullDeck(s: DataSnapshot) -> [Deck]{
        var decksII: [Deck] = []
        
        //For loops to create the decks locally
        if let result = s.children.allObjects as? [DataSnapshot] {
            //Gets the name of the deck
            for child in result {
                let placeHolderDeck: Deck = Deck()
                placeHolderDeck.name = child.key
                //inside for loop to create the flashcards to populate the deck
                for i in 0..<s.childSnapshot(forPath: "\(placeHolderDeck.name)/Cards").childrenCount{
                    let placeHolderCard: FlashCard = FlashCard()

                    if let definition =
                        s.childSnapshot(forPath: "\(placeHolderDeck.name)/Cards/\(String(i))/Definition").value as? String{
                        placeHolderCard.definition = definition
                    }
                    if let term = s.childSnapshot(forPath: "\(placeHolderDeck.name)/Cards/\(String(i))/Term").value as? String{
                        placeHolderCard.term = term
                    }

                    placeHolderDeck.cards.append(placeHolderCard)

                }
                decksII.append(placeHolderDeck)
            }
        }
        
        return decksII
    }
        
   
    func setUpAddDeckButton(){
        //adding to view
        view.addSubview(addDeckButton)
        
        //setting up properties
        addDeckButton.setTitle("Add Deck", for: .normal)
        addDeckButton.setTitleColor(UIColor.lightGray, for: .normal)
        addDeckButton.backgroundColor = UIColor.black
        addDeckButton.addTarget(self, action: #selector(addDeckSegue), for: .touchUpInside)
        addDeckButton.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        addDeckButton.translatesAutoresizingMaskIntoConstraints = false
        addDeckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addDeckButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
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
    
    //code that runs when a cell is clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as? DeckCell
        
        //finds deck that corresponds with label
        if let cell = currentCell?.deckLabel.text{
            for i in decks{
                if cell == i.name{
                    workingDeck = i
                }
            }
        }
        
        //goes to EditDeck
        performSegue(withIdentifier: "toEditDeck", sender: self)
        print("Moving to edit deck")
    }
    
    //sends the deck clicked on over to the EditDeckView Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDeck" {
            let controller = segue.destination as! EditDeckViewController
            controller.masterDeck = workingDeck
        }
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
