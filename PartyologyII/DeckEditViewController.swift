//
//  DeckEditViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class DeckEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func addDeck(_ dictionary: Dictionary, _ completion: @escaping((_ url:URL?) -> ())){
        // get the current user's userid
        guard let uid = Auth.auth().currentUser?.uid else {return}
            
         // get a reference to the storage object
         let storage = Storage.storage().reference().child("user/\(uid)")
            
         // image's must be saved as data obejct's so convert and compress the image.
         guard let image = imageView?.image, let imageData = UIImageJPEGRepresentation(image, 0.75) else {return}
         
         // store the image
         storage.putData(imageData, metadata: StorageMetadata()) { (metaData, error) in
            }
        }


}
