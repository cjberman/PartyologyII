//
//  FibbageViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit

class term {
    var text:String = "Placeholder"
    var player:Int = 0
    
    init(){
    }
    
    init(text:String,player:Int){
        self.text=text
        self.player=player
    }
}

class FibbageViewController: UIViewController {
    //buhhhh
    //text field for player to enter term, button to enter, placeholder array to hold terms, placeholder definition and term for before flashcards, placeholder player count [very bad please fix delete later (maybe not tho, the best way to pass this info might be instantiating new values in placeholder variables from another class)]
    
    let placeholderDefinition = "A series of chemical reactions used by all aerobic organisms to release stored energy through the oxidation of acetyl-CoA derived from carbohydrates, fats, and proteins, into adenosine triphosphate and carbon dioxide"
    let placeholderTerm = term(text:"Krebs Cycle",player:0)
    var termsArray : [term] = []
    var scores:[Int:Int]=[1:0,2:0,3:0]

    var playerCount = 1
    var definitionLabel = UILabel()
    var playerCounter = UILabel()
    var falseTermField = UITextField()
    let enter = UIButton()
    
    
    
    
    //Function used in order to update from fibtableview class
    func updateScores(key:Int, value:Int){
        scores[key]=value
        
        print(scores)
    }
    
    func setUpDefinition(){
        //adding to view
        view.addSubview(definitionLabel)
        
        //setting up properties
        definitionLabel.backgroundColor = UIColor.orange
        definitionLabel.text = "\(placeholderDefinition)"
        definitionLabel.textColor = UIColor.white
        definitionLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        definitionLabel.adjustsFontSizeToFitWidth = true
        definitionLabel.layer.cornerRadius = 30
        
        
        
        //constraints
        definitionLabel.preferredMaxLayoutWidth = view.frame.width-60
        definitionLabel.numberOfLines = 0
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        definitionLabel.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        definitionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
    }
    
    func setUpPlayerCounter(){
        //adding to view
        view.addSubview(playerCounter)
        
        //setting up properties
        playerCounter.text = "Player \(playerCount)"
        playerCounter.textColor = UIColor.red
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
        enter.setTitle("  Enter  ", for: .normal)
        enter.setTitleColor(UIColor.white, for: .normal)
        enter.backgroundColor = UIColor.red
        enter.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        enter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        enter.layer.cornerRadius = 20
        
        //constraints
        enter.translatesAutoresizingMaskIntoConstraints = false
        enter.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        enter.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func enterButton(){
        if let newTermText = falseTermField.text{
            //Add new false term to array, clear text field
            let newTerm = term(text: newTermText, player: playerCount)
            termsArray.append(newTerm)
            let vc = FibTableView(nibName: "FibTableView", bundle: nil)
            vc.termArray = termsArray
            vc.scores = scores
            print(vc.termArray)
            falseTermField.text = ""
            
            //fix this later to reflect actual player count
            playerCount+=1
            if playerCount>3{
                
                //shuffles and sends array to selection screen,
                termsArray.append(placeholderTerm)
                termsArray.shuffle()
                performSegue(withIdentifier: "toFibTable", sender: self)
                return
            }
            //Updates player counter
            setUpPlayerCounter()
            print(termsArray)
        }
        else {return}
    }
    
    //segue to FibTable class uhh haha I did something kinda dumb, this might mess with the login screen lol
    //I'll fix it later but basically that line that mentions the "toHome" segue hijacks it and sends it to mine
    //when we get the storyboard together I'll fix that
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFibTable" {
            let controller = segue.destination as! FibTableView
            controller.termArray = termsArray
            controller.definition = placeholderDefinition

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEnter()
        setUpFalseTermField()
        setUpPlayerCounter()
        setUpDefinition()
        

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
