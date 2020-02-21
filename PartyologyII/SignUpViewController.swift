//
//  SignUpViewController.swift
//  PartyologyII
//
//  Created by Charles Berman (student LM) on 2/20/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    //text fields and buttons to sign in with
    var emailAddress = UITextField()
    var username = UITextField()
    var password = UITextField()
    let signUp = UIButton()
    
    func setUpEmailAddress(){
        //adding to view
        view.addSubview(emailAddress)
        
        //setting up properties
        emailAddress.placeholder = "Email Address"
        emailAddress.textColor = UIColor.lightGray
        emailAddress.font = UIFont(name: "Helvetica Neue", size: 30)
        emailAddress.adjustsFontSizeToFitWidth = true
        emailAddress.keyboardType = UIKeyboardType.emailAddress
        
        //constraints
        emailAddress.translatesAutoresizingMaskIntoConstraints = false
        emailAddress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailAddress.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
    }
    
    func setUpUsername(){
       //adding to view
        view.addSubview(username)
        
        //setting up properties
        username.placeholder = "Username"
        username.textColor = UIColor.lightGray
        username.font = UIFont(name: "Helvetica Neue", size: 30)
        username.adjustsFontSizeToFitWidth = true
        
        //constraints
        username.translatesAutoresizingMaskIntoConstraints = false
        username.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        username.topAnchor.constraint(equalTo: emailAddress.bottomAnchor, constant: 100).isActive = true
    }
    
    func setUpPassword(){
        //adding to view
        view.addSubview(password)
        
        //setting up properties
        password.placeholder = "Password"
        password.textColor = UIColor.lightGray
        password.font = UIFont(name: "Helvetica Neue", size: 30)
        password.adjustsFontSizeToFitWidth = true
        password.isSecureTextEntry = true
            
        //constraints
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 100).isActive = true
    }
    
    func setUpSignUp(){
        //adding to view
        view.addSubview(signUp)
        
        //setting up properties
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(UIColor.lightGray, for: .normal)
        signUp.backgroundColor = UIColor.blue
        signUp.addTarget(self, action: #selector(signUpButton), for: .touchUpInside)
        signUp.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        
        //constraints
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        signUp.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    //function for the sign up button operation
    @objc func signUpButton(){
        guard let email = emailAddress.text else {return}
        guard let password = password.text else {return}
        guard let username = username.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if let _ = user {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in print("couldn't change name")
                })
                self.dismiss(animated: true, completion: nil)
                
                self.resignFirstResponder()
            }
            else{
                print(error.debugDescription)
            }
        }
        
        performSegue(withIdentifier: "toHome", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmailAddress()
        setUpUsername()
        setUpPassword()
        setUpSignUp()
        
        emailAddress.becomeFirstResponder()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        if emailAddress.isFirstResponder{
            username.becomeFirstResponder()
        }
        else if username.isFirstResponder{
            password.becomeFirstResponder()
        }
        else{
            password.resignFirstResponder()
            signUp.isEnabled = true
        }
        
        return true
    }
    


}
