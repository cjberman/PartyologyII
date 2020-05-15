//
//  EditNewFlashcardViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 5/9/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class EditNewFlashcardViewController: UIViewController {
    
    var cardTerm = UITextField()
    var cardDefinition = UITextField()
    var addCard = UIButton()
    var theOneDeckToRuleThemAll = Deck()
    
    var newCard = FlashCard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCardTerm()
        setUpCardDefition()
        setUpButton()
        

    }
    
    
    func setUpCardTerm(){
        //adding to view
        view.addSubview(cardTerm)
        
        //setting up properties
        
        
        cardTerm.placeholder = "Enter Term"
        
        cardTerm.textColor = UIColor.lightGray
        cardTerm.font = UIFont(name: "CourierNewPSMT", size: 30)
        cardTerm.adjustsFontSizeToFitWidth = true
        
        //        cardTerm.textFieldStyle(RoundedBorderTextFieldStyle())
        //constraints
        cardTerm.translatesAutoresizingMaskIntoConstraints = false
        cardTerm.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        cardTerm.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
    }
    
    func setUpCardDefition(){
        //adding to view
        view.addSubview(cardDefinition)
        
        //setting up properties
        
        cardDefinition.placeholder = "Enter Definition"
        
        cardDefinition.textColor = UIColor.lightGray
        cardDefinition.font = UIFont(name: "CourierNewPSMT", size: 30)
        cardDefinition.adjustsFontSizeToFitWidth = true
        //        cardDefinition.textFieldStyle(RoundedBorderTextFieldStyle())
        
        //constraints
        cardDefinition.translatesAutoresizingMaskIntoConstraints = false
        cardDefinition.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        cardDefinition.topAnchor.constraint(equalTo: cardTerm.bottomAnchor, constant: 50).isActive = true
    }
    
    func setUpButton(){
        //adding to view
        view.addSubview(addCard)
        
        //setting up properties
        addCard.setTitle("Add Card", for: .normal)
        addCard.setTitleColor(UIColor.lightGray, for: .normal)
        addCard.backgroundColor = UIColor.black
        addCard.addTarget(self, action: #selector(backToEditDeck), for: .touchUpInside)
        addCard.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        addCard.translatesAutoresizingMaskIntoConstraints = false
        addCard.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addCard.centerYAnchor.constraint(equalTo: cardDefinition.bottomAnchor, constant: 50).isActive = true
    }
    
    @objc func backToEditDeck(){
        //setting term and definition
        
        if let term = cardTerm.text{
            newCard.term = term
        }
        if let definition = cardDefinition.text {
            newCard.definition = definition
        }
        
        theOneDeckToRuleThemAll.cards.append(newCard)
        
        print(theOneDeckToRuleThemAll.name)
        
        self.performSegue(withIdentifier: "backToEditDeck2", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToEditDeck2" {
            let controller = segue.destination as! EditDeckViewController
            controller.masterDeck = theOneDeckToRuleThemAll
            controller.theOldName = theOneDeckToRuleThemAll.name
        }
    }
}
