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
    let deck = Deck()
    let termLabel = UILabel()
    var motionManager = CMMotionManager()
    
    
    //set up label
    func setUptermLabel(){
        //adding to view
        view.addSubview(termLabel)
        
        //setting up properties
        
        termLabel.text = "Placeholder"
        termLabel.textColor = UIColor.black
        termLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        
        //constraints
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        termLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        termLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
        
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accelerometer(false)
        
        setUptermLabel()
        
        view.backgroundColor = UIColor.white
    }
        
        
        
        
    func accelerometer(_ animated: Bool){
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {(data, error) in if let myData = data{
            //                    print(myData)
            
            if myData.acceleration.z > 0.6{
                self.view.backgroundColor = UIColor.red
            }
            else if myData.acceleration.z < -0.6{
                self.view.backgroundColor = UIColor.green
            }
            else{
                self.view.backgroundColor = UIColor.white
            }
            }
            
        }
    }
    
    
}

