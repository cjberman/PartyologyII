//
//  GameChooseViewController.swift
//  PartyologyII
//
//  Created by Noah Wheeler (student LM) on 3/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import Foundation
import UIKit
//import FirebaseAuth

class GameChooseViewController: UIViewController {
    
    var deck = Deck()

    let fibbageButton = UIButton()
    let headsUpButton = UIButton()
    
    func assignbackground(){

          view.backgroundColor = UIColor.black

     }
    
    func setUpFibbageButton(){
                view.addSubview(fibbageButton)
               
               fibbageButton.setTitle("Fibbage", for: .normal)
                fibbageButton.setTitleColor(UIColor.black, for: .normal)
               fibbageButton.backgroundColor = UIColor.red
               fibbageButton.addTarget(self, action: #selector(fromFibbageButton), for: .touchUpInside)
               fibbageButton.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
               
               //constraints
               fibbageButton.translatesAutoresizingMaskIntoConstraints = false
               fibbageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
               fibbageButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
           }
        
        @objc func fromFibbageButton(){
               self.performSegue(withIdentifier: "toFibbage", sender: self)
        }
        
        func setUpHeadsUpButton(){
                       view.addSubview(headsUpButton)
                      
                      headsUpButton.setTitle("Heads Up", for: .normal)
                       headsUpButton.setTitleColor(UIColor.black, for: .normal)
                    headsUpButton.backgroundColor = UIColor.blue
                      headsUpButton.addTarget(self, action: #selector(fromHeadsUpButton), for: .touchUpInside)
                      headsUpButton.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
                      
                      //constraints b
                      headsUpButton.translatesAutoresizingMaskIntoConstraints = false
                      headsUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
                      headsUpButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
                  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="toHeadsUp"{
            let controller = segue.destination as! HeadsUpViewController
            controller.deck = deck
        }
    }
               
               @objc func fromHeadsUpButton(){
                    print(deck)
                      self.performSegue(withIdentifier: "toHeadsUp", sender: self)
               }
               
    
    
    
    func firstResponder(){
//           if (Auth.auth().currentUser != nil) {
//               self.becomeFirstResponder()
//
//           }
       }
       
       override func viewDidLoad() {
            super.viewDidLoad()
            firstResponder()
            assignbackground()
            setUpFibbageButton()
            setUpHeadsUpButton()
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
