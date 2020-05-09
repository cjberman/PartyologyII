//
//  EditDeckViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 4/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class EditDeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let editDeckName = UITextField()
    var masterDeck = Deck()
    
    let deckList: UITableView = {
           let tv = UITableView()
           tv.backgroundColor = UIColor.black
           tv.separatorColor = UIColor.white
           tv.translatesAutoresizingMaskIntoConstraints = false
           return tv
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpDeckName()
        setupDeckList()

    }
    
    func setUpDeckName(){
            //adding to view
        view.addSubview(editDeckName)
            
            //setting up properties
        editDeckName.placeholder = masterDeck.name
        editDeckName.textColor = UIColor.lightGray
        editDeckName.font = UIFont(name: "CourierNewPSMT", size: 30)
        editDeckName.adjustsFontSizeToFitWidth = true
    //        deckName.textFieldStyle(RoundedBorderTextFieldStyle())
                
            //constraints
            editDeckName.translatesAutoresizingMaskIntoConstraints = false
            editDeckName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
            editDeckName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        }
    
    func setupDeckList() {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return masterDeck.cards.count
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DeckCell
          // cell.backgroundColor = UIColor.white
           cell.deckLabel.text = "\(masterDeck.cards[indexPath.row])"
           return cell
       }
     
       let tableview: UITableView = {
           let tv = UITableView()
           tv.backgroundColor = UIColor.black
           tv.separatorColor = UIColor.white
           tv.translatesAutoresizingMaskIntoConstraints = false
           return tv
       }()
}
