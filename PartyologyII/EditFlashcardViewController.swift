//
//  EditFlashcardViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 5/8/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class EditFlashcardViewController: UIViewController {
    var masterFlashcard = FlashCard()
    var theDeckOfTruth = Deck()
    
    var cardTerm = UITextField()
    var cardDefinition = UITextField()
    var update = UIButton()
    
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
    if  masterFlashcard.term != ""{
            cardTerm.placeholder = masterFlashcard.term
    }
    else{
        cardTerm.placeholder = "Enter Term"
    }
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
            if masterFlashcard.definition != ""{
                cardDefinition.placeholder = masterFlashcard.definition
            }
            else{
                cardDefinition.placeholder = "Enter Definition"
            }
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
        view.addSubview(update)
            
            //setting up properties
        update.setTitle("Update", for: .normal)
        update.setTitleColor(UIColor.lightGray, for: .normal)
        update.backgroundColor = UIColor.black
        update.addTarget(self, action: #selector(backToEditDeck), for: .touchUpInside)
        update.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        update.translatesAutoresizingMaskIntoConstraints = false
        update.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        update.centerYAnchor.constraint(equalTo: cardDefinition.bottomAnchor, constant: 50).isActive = true
        }
    
    @objc func backToEditDeck(){
        //setting term and definition
        guard let termText = cardTerm.text else {return}
        guard let termDefinition = cardDefinition.text else {return}
        
        if termText != ""{
            masterFlashcard.term = termText
        }
        
        if termDefinition != ""{
            masterFlashcard.definition = termDefinition
        }
        
        self.performSegue(withIdentifier: "backToEditDeck", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToEditDeck" {
            let controller = segue.destination as! EditDeckViewController
            controller.masterDeck.cards = theDeckOfTruth.cards
        }
    }


}
