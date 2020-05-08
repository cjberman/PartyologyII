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
    let titleLabel = UILabel()
    let background = UIImage(named: "Controllerrr.png")
  
    func assignbackground(){
        
        view.backgroundColor = UIColor.black

        
//        Changed the background to black and added an neon controller png to fit the aesthetic.
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)

        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.image = background
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
       
        imageView.frame.size.width = 200
        imageView.frame.size.height = 200
        imageView.center = self.view.center
        view.addSubview(imageView)
               self.view.sendSubviewToBack(imageView)
   }
    
    
    func setUpTitleLabel(){
        //adding to view
        view.addSubview(titleLabel)
        
        //setting up properties
        titleLabel.text = "PARTYOLOGY"
        titleLabel.textColor = UIColor.green
        titleLabel.font = UIFont(name: "CourierNewPSMT", size: 64)
        
        //constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
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
//Updated upstream
        deckEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        deckEdit.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

        deckEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60).isActive = true
        deckEdit.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -600).isActive = true
//Stashed changes
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
           deckChoose.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
           deckChoose.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
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
        setUpTitleLabel()
    }


}
