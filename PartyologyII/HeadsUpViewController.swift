//
//  HeadsUpViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import CoreMotion

class HeadsUpViewController: UIViewController {
    
    //instantiate deck
    let deck = Deck(c: [FlashCard("Basketball", "A"), FlashCard("Giraffe", "B"), FlashCard("Skiing", "C"),FlashCard("Handshake", "D") ], n: "Random Things")
    
    let termLabel = UILabel()
    let pointLabel = UILabel()
    let timeLabel = UILabel()
    
    var termWasChanged = false
    var points = 0
    var timer = Timer()
    var time = 0
    
    var motionManager = CMMotionManager()
    
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        accelerometer(false)
        
        setUpTermLabel()
        setUpPointLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HeadsUpViewController.timeAction), userInfo: nil, repeats: true)
        view.backgroundColor = UIColor.white
    }
        
    @objc func timeAction(){
        time += 1
        timeLabel.text = String(time)
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .landscape
    }
    
    
    
    //set up termLabel
    func setUpTermLabel(){
        //adding to view
        view.addSubview(termLabel)
        
        //setting up properties
        
        if let card = deck.getRandomCard(){
            termLabel.text = card.term
        } else{
            termLabel.text = "error: deck contains null values"
        }
        termLabel.textColor = UIColor.black
        termLabel.font = UIFont(name: "Helvetica Neue", size: 64)
        
        //constraints
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        termLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
        
        
    func setUpPointLabel(){
        //adding to view
        view.addSubview(pointLabel)
        
        //setting up properties
        pointLabel.text = "\(points)"
        pointLabel.textColor = UIColor.black
        pointLabel.font = UIFont(name: "Helvetica Neue", size: 64)
        
        //constraints
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pointLabel.bottomAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 100).isActive = true
    }
        
    
    
        
    func accelerometer(_ animated: Bool){
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {(data, error) in if let myData = data{
            //                    print(myData)
            
            if myData.acceleration.z > 0.6{
                self.view.backgroundColor = UIColor.red
                
                if(!self.termWasChanged){
                    self.termLabel.text = self.deck.getRandomCard()?.term
                    self.termWasChanged = true
                }
                
            }
            else if myData.acceleration.z < -0.6{
                self.view.backgroundColor = UIColor.green
                
                if(!self.termWasChanged){
                    self.termLabel.text = self.deck.getRandomCard()?.term
                    self.points += 100
                    self.setUpPointLabel()
                    self.termWasChanged = true
                }
            }
            else{
                self.termWasChanged = false
                self.view.backgroundColor = UIColor.white
            }
            }
            
        }
    }
    
    
}

