//
//  DeckChooseTableView.swift
//  PartyologyII
//
//  Created by Noah Wheeler (student LM) on 3/6/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
class DeckChooseTableView: UIViewController, UITableViewDelegate,  UITableViewDataSource{

//UI FUNCTIONS AND NON TABLE VARIABLES
    var deckName: String = "fake deck name"
    var deckNameLabel = UILabel()
    let enterButton = UIButton()
    var deckk = DeckEditViewController()
    var deckArray = [Deck]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?

    
    @objc func enterBut(){
        
         //path row is how we'll keep track of player choices
        guard let path = tableview.indexPathForSelectedRow else {return}
        print(path.row)
        
        tableview.deselectRow(at: path, animated: false)
        
    
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let rowPath = tableview.indexPathForSelectedRow?.row else {return}
        
        if segue.identifier=="toGameChoose"{
            let controller = segue.destination as! GameChooseViewController
            controller.deck = deckArray[rowPath]
        }
    }
    
    @objc func fromEnterButton(){
        performSegue(withIdentifier: "toGameChoose", sender: self)
        
    }
    
    
    func setUpName(){
        //adding to view
        view.addSubview(deckNameLabel)
        
        //setting up properties
        deckNameLabel.text = "\(deckName)"
        deckNameLabel.textColor = UIColor.black
        deckNameLabel.font = UIFont(name: "CourierNewPSMT", size: 20)
        deckNameLabel.adjustsFontSizeToFitWidth = true
        
        //constraints
        deckNameLabel.preferredMaxLayoutWidth = view.frame.width-60
        deckNameLabel.numberOfLines = 0
        deckNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deckNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        deckNameLabel.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        deckNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckArray.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DeckCell
       // cell.backgroundColor = UIColor.white
        cell.deckLabel.text = "\(deckArray[indexPath.row].name)"
        return cell
    }
  
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.black
        tv.separatorColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //set up table view class
    func setupTableView() {
        //register is really important
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(DeckCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        //constraints
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    func bottomUp() {
       let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 83))
        bottomView.backgroundColor = .clear
       // tableView.tableFooterView = bottomView
    }
    
    //view did load
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        ref?.child("Decks").observe(.value, with: { (snapshot) in
            for i in self.deckk.pullDeck(s: snapshot){
                self.deckk.decks.append(i)
            }
            self.deckArray=self.deckk.decks
            self.setupTableView()
        })
        
        //setUpName()
        setUpEnter()
    }
}


//CELL FUNCTIONS
class DeckCell: UITableViewCell {
    
    
    //initializes the cells when called in table i think
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    //All the important cell constraints
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(deckLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        deckLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        deckLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        deckLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        deckLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
    
    //Cell background properties
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        //corner radius is the rounding edges thing that looks nice for future reference
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deckLabel: UILabel = {
        let label = UILabel()
        label.text = "Deck Name"
        var num = Int.random(in: 1...5)
        if(num == 1){
                label.textColor = UIColor.blue
        }
        else if(num == 2){
            label.textColor = UIColor.red
        }
        else if(num == 3){
            label.textColor = UIColor.yellow
        }
        else if(num == 4){
            label.textColor = UIColor.green
        }
        else{
            label.textColor = UIColor.white
        }
        
        label.font = UIFont(name: "CourierNewPSMT", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
