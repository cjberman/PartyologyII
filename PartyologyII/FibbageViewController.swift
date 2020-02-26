//
//  FibbageViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class FibbageViewController: UIViewController {
    //buhhhh
    //text field for player to enter term, button to enter, placeholder array to hold terms, placeholder definition and term for before flashcards, placeholder player count [very bad please fix delete later]
    
    let placeholderDefinition = "A series of chemical reactions used by all aerobic organisms to release stored energy through the oxidation of acetyl-CoA derived from carbohydrates, fats, and proteins, into adenosine triphosphate and carbon dioxide"
    let placeholderTerm = "Krebs Cycle"
    var termsArray : [String] = []
    
    var playerCount = 1
    var playerCounter = UILabel()
    var falseTermField = UITextField()
    let enter = UIButton()
    
    func setUpPlayerCounter(){
        //adding to view
        view.addSubview(playerCounter)
        
        //setting up properties
        playerCounter.text = "Player \(playerCount)"
        playerCounter.textColor = UIColor.lightGray
        playerCounter.font = UIFont(name: "Helvetica Neue", size: 30)
        playerCounter.adjustsFontSizeToFitWidth = true
        
        //constraints
        playerCounter.translatesAutoresizingMaskIntoConstraints = false
        playerCounter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        playerCounter.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func setUpFalseTermField(){
        //adding to view
        view.addSubview(falseTermField)
        
        //setting up properties
        falseTermField.placeholder = "Enter False Term"
        falseTermField.textColor = UIColor.lightGray
        falseTermField.font = UIFont(name: "Helvetica Neue", size: 30)
        falseTermField.adjustsFontSizeToFitWidth = true
        falseTermField.keyboardType = UIKeyboardType.alphabet
        
        //constraints
        falseTermField.translatesAutoresizingMaskIntoConstraints = false
        falseTermField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        falseTermField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    func setUpEnter(){
        //adding to view
        view.addSubview(enter)
        
        //setting up properties
        enter.setTitle("Enter", for: .normal)
        enter.setTitleColor(UIColor.lightGray, for: .normal)
        enter.backgroundColor = UIColor.blue
        enter.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        enter.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        
        //constraints
        enter.translatesAutoresizingMaskIntoConstraints = false
        enter.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        enter.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func enterButton(){
        if let newTerm = falseTermField.text{
            //Add new false term to array, clear text field
            termsArray.append(newTerm)
            falseTermField.text = ""
            
            //fix this later to reflect actual player count
            playerCount+=1
            
            //Updates player counter
            setUpPlayerCounter()
            print(termsArray)
        }
        else {return}
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEnter()
        setUpFalseTermField()
        setUpPlayerCounter()
        

        // Do any additional setup after loading the view.
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
