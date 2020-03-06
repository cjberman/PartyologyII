//
//  DeckChooseViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

//import FirebaseAuth

class DeckChooseViewController: UIViewController {

    let enterButton = UIButton()
    //let deckLabel = UILabel()
 //   var accessDecks: DeckEditViewController = DeckEditViewController()
    
    //var deck: NSArray = NSArray()
    
    

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
  
    
    func setUpEnter(){
        view.addSubview(enterButton)
               
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(UIColor.red, for: .normal)
        enterButton.backgroundColor = UIColor.black
        enterButton.addTarget(self, action: #selector(fromEnterButton), for: .touchUpInside)
        enterButton.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
               
               //constraints
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        enterButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
//    func setUpScrollView(){
//        self.view.addSubview(scrollView)
//
//        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
    
//        let accessDecks: DeckEditViewController = DeckEditViewController()
//        var deck = accessDecks.deckList()
//        scrollView.addSubview(deckLabel)
//        deckLabel.text = "deck[0].name"
//        deckLabel.backgroundColor = UIColor.black
//        deckLabel.textColor = .red
//        deckLabel.translatesAutoresizingMaskIntoConstraints = false
//        deckLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 80.0).isActive = true
//        deckLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200.0).isActive = true
//    }
    
    
        @objc func fromEnterButton(){
               self.performSegue(withIdentifier: "toGameChoose", sender: self)
        }
        
        func firstResponder(){
     
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            firstResponder()
            
            setUpEnter()
            //setUpScrollView()
            
        
        }
}
