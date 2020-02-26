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
    let definitionLabel = UILabel()
    var motionManager = CMMotionManager()
    
    
    //set up label
    func setUpDefinitionLabel(){
        //adding to view
        view.addSubview(definitionLabel)
        
        //setting up properties
        
        definitionLabel.text = "Placeholder"
        definitionLabel.textColor = UIColor.black
        definitionLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        
        //constraints
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        definitionLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    
        
    //viewDidLoad
    func viewDidLoad() {
        super.viewDidLoad()
        
        accelerometer(false)
        
        setUpDefinitionLabel()
        
        //May or may not have to optional bind this
        definitionLabel.text = deck.getCard()?.definition

        
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
    
    func gyroscope(_ animated: Bool){
        motionManager.gyroUpdateInterval = 0.2
        //        var movement = true
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) {(data, error) in if let myData = data{
            
            if myData.rotationRate.y > 1.75{
                print("Rotate back")
                print(myData.rotationRate.y)
                self.view.backgroundColor = UIColor.red
                
                
                
                
            }
            else if myData.rotationRate.y < -1.75{
                print("Rotate forward")
                print(myData.rotationRate.y)
                self.view.backgroundColor = UIColor.green
                
                
                
                
                
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {

                
            }
            
            }
        }
        
    }
    
}
}
