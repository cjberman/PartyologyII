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

    
    func assignbackground(){
        let background = UIImage(named: "arcadeScreen.jpg")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func firstResponder(){
        if (Auth.auth().currentUser != nil) {
            self.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        firstResponder()
        super.viewDidLoad()
        assignbackground()
       
    }


}
