//
//  HomeScreenViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeScreenViewController: UIViewController {

    let deckEdit = UIButton()
    let deckChoose = UIButton()
    let background = UIImage(named: "arcadeScreen.jpg")
    
    func assignbackground(){

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setUpDeckEdit(){
        view.addSubview(deckEdit)
        
        //setting up properties
        deckEdit.setTitle("Edit Deck", for: .normal)
        deckEdit.setTitleColor(UIColor.red, for: .normal)
        deckEdit.backgroundColor = UIColor.black
        deckEdit.addTarget(self, action: #selector(deckEditButton), for: .touchUpInside)
        deckEdit.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        //constraints
        deckEdit.translatesAutoresizingMaskIntoConstraints = false
        deckEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60).isActive = true
        deckEdit.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -400).isActive = true
    }
    
    @objc func deckEditButton(){
        self.performSegue(withIdentifier: "toDeckEdit", sender: self)
    }
    
    func setUpDeckChoose(){
           view.addSubview(deckChoose)
           
           deckChoose.setTitle("Choose Deck", for: .normal)
        deckChoose.setTitleColor(UIColor.blue, for: .normal)
           deckChoose.backgroundColor = UIColor.black
           deckChoose.addTarget(self, action: #selector(deckChooseButton), for: .touchUpInside)
           deckChoose.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
           
           //constraints
           deckChoose.translatesAutoresizingMaskIntoConstraints = false
           deckChoose.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60).isActive = true
           deckChoose.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true
       }
    
    @objc func deckChooseButton(){
           self.performSegue(withIdentifier: "toDeckChoose", sender: self)
       }
    
    func firstResponder(){
        if (Auth.auth().currentUser != nil) {
            self.becomeFirstResponder()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        firstResponder()
        setUpDeckEdit()
        setUpDeckChoose()
    }


}
