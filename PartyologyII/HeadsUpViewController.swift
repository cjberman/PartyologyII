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
    
    //declarations
    //test deck - will be eventually replaced
    var deck = Deck([FlashCard("Basketball", "A"), FlashCard("Giraffe", "B"), FlashCard("Skiing", "C"),FlashCard("Handshake", "D") ], "Random Things")
    //labels & button
    let termLabel = UILabel()
    let pointLabel = UILabel()
    let timeLabel = UILabel()
    let exitButton = UIButton()
    
    //termWasChanged - used for ensuring the term is only changed once when device is tilted
    var termWasChanged = false
    //points - keeps track of points
    var points = 0
    var timer = Timer()
    //time - starts at 60, decreases by 1 every second
    var time = 60
    //motionManager - needed for accelerometer
    var motionManager = CMMotionManager()
    
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //calls acceleromter
        accelerometer(false)
        
        //sets up labels & button
        setUpTermLabel()
        setUpPointLabel()
        setUpTimeLabel()
        setUpExitButton()
        
        view.backgroundColor = UIColor.white
        
        //sets up timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HeadsUpViewController.timeAction), userInfo: nil, repeats: true)
        
    }
    
    //called every second
    @objc func timeAction(){
        //decreses time and updates timeLabel
        time -= 1
        timeLabel.text = String(time)
        
        //game over sequence
        if (time <= 0){
            view.backgroundColor = UIColor.black
            termLabel.text = "GAME OVER"
            termLabel.textColor = UIColor.white
            pointLabel.textColor = UIColor.white
            exitButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        
    }
    
    //locks app in landscape mode
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    
    
    //set up labels & button
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
    
    func setUpTimeLabel(){
        //adding to view
        view.addSubview(timeLabel)
        
        //setting up properties
        timeLabel.text = "60"
        timeLabel.textColor = UIColor.black
        timeLabel.font = UIFont(name: "Helvetica Neue", size: 64)
        
        //constraints
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func setUpExitButton(){
        //adding to view
        view.addSubview(exitButton)
        
        //setting up properties
        exitButton.setTitle("X", for: .normal)
        exitButton.setTitleColor(UIColor.black, for: .normal)
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        exitButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 64)
        
        //constraints
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    //called when exitButton is pressed
    @objc func exit(){
        //segue here
    }
    
    func accelerometer(_ animated: Bool){
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {(data, error) in if let myData = data{
            
            //turns off accelerometer once time is up
            if (self.time > 0){
                
                //sequence when device is tilted down
                if myData.acceleration.z > 0.6{
                    self.view.backgroundColor = UIColor.red
                    
                    //updates term
                    if(!self.termWasChanged){
                        self.termLabel.text = self.deck.getRandomCard()?.term
                        self.termWasChanged = true
                    }
                    
                }
                //sequence when device is tilted up
                else if myData.acceleration.z < -0.6{
                    self.view.backgroundColor = UIColor.green
                    
                    //updates term and points
                    if(!self.termWasChanged){
                        self.termLabel.text = self.deck.getRandomCard()?.term
                        self.points += 100
                        self.setUpPointLabel()
                        self.termWasChanged = true
                    }
                }
                //sequence when device is returned to neutral
                else{
                    self.termWasChanged = false
                    self.view.backgroundColor = UIColor.white
                }
            }
            }
        }
    }
    
    
}

