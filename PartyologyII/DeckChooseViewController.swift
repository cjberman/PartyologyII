//
//  DeckChooseViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class DeckChooseViewController: UIViewController {

    let enterButton = UIButton()
    
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
        
        @objc func fromEnterButton(){
               self.performSegue(withIdentifier: "toGameChoose", sender: self)
           }
        
        
    
    
    
    
    
    func firstResponder(){
           if (Auth.auth().currentUser != nil) {
               self.becomeFirstResponder()

           }
       }
       
       override func viewDidLoad() {
            super.viewDidLoad()
            firstResponder()
            setUpEnter()
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
