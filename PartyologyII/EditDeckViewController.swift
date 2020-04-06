//
//  EditDeckViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 4/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class EditDeckViewController: UIViewController {
    
    let devc = DeckEditViewController()
    
    let editDeckName = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDeckName()

    }
    

//    func findWorkingDeck() -> Deck{
//        devc.workingDeckName
//        
//        
//        
//        return
//    }

    
    func setUpDeckName(){
            //adding to view
            view.addSubview(editDeckName)
            
            //setting up properties
            editDeckName.placeholder = "Change Deck Name"
            editDeckName.textColor = UIColor.lightGray
            editDeckName.font = UIFont(name: "Helvetica Neue", size: 30)
            editDeckName.adjustsFontSizeToFitWidth = true
    //        deckName.textFieldStyle(RoundedBorderTextFieldStyle())
                
            //constraints
            editDeckName.translatesAutoresizingMaskIntoConstraints = false
            editDeckName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
            editDeckName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        }
}
