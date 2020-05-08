//
//  FibTableView.swift
//  PartyologyII
//
//  Created by Julius Murphy (student LM) on 3/2/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//
import UIKit
import Foundation
class FibTableView: UIViewController, UITableViewDelegate,  UITableViewDataSource{

//UI FUNCTIONS AND NON TABLE VARIABLES
//The majority of the following declarations and setup functions are poached from the Fibbage class, if i can find a way to like do macros or not take up all this space with identical code i'll get rid of it but thats low priority
    var definition: String = ""
    var termArray = [term]()
    var scores = [Int:Int]()
    var definitionLabel = UILabel()
    var playerCounter = UILabel()
    var playerCount = 1
    let enter = UIButton()
    var deck=Deck()
    
    //This is an instance of the first view controller, NOT THE ACTUAL THING
    //I WILL NEED TO GO BACK AND EITHER PASS WHATS IN THIS BACK OR PUSH THE DATA FROM IT TO THE END SCREEN
    let vc = FibbageViewController(nibName: "FibbageViewController", bundle: nil).self
    
    func setUpPlayerCounter(){
        //adding to view
        view.addSubview(playerCounter)
        
        //setting up properties
        playerCounter.text = "Player \(playerCount)"
        playerCounter.textColor = UIColor.black
        playerCounter.font = UIFont(name: "CourierNewPSMT", size: 30)
        playerCounter.adjustsFontSizeToFitWidth = true
        
        //constraints
        playerCounter.translatesAutoresizingMaskIntoConstraints = false
        playerCounter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        playerCounter.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
    @objc func enterButton(){
        
        //path row is how we'll keep track of player choices
        guard let path = tableview.indexPathForSelectedRow else {return}
        let cell = tableview.cellForRow(at: path) as! TermCell
        print(cell.playerKey)
        
    //THE FOLLOWING IF ELSE DOES NOT CHANGE THE DICTIONARY IN THE FIBBAGE CLASS
    //IT CHANGES THE INSTANCE OF THE CLASS INSTANTIATED IN THIS CLASS
    //WHEN A SEGUE IS MADE BACK TO THE FIRST CLASS OR TO THE END SCREEN THE DATA FROM THE INSTANCE SHOULD BE SENT
    //I JUST HAVENT DONE THAT PART YET
    //IT CURRENTLY JUST MAPS THE VALUE IN THE INSTANCE TO A DICTIONARY IN THIS CLASS
        //If player chooses the correct answer
        if(cell.playerKey==0){
            guard let currentPlayerScore = scores[playerCount] else {return}
            //vc.updateScores(key: playerCount, value: currentPlayerScore+2)
            scores[playerCount] = currentPlayerScore+2
        }
        //If player chooses a false answer
        else{
            guard let currentPlayerScore = scores[cell.playerKey] else {return}
            //vc.updateScores(key: cell.playerKey, value: currentPlayerScore+1)
            scores[cell.playerKey] = currentPlayerScore+1
        }
        //scores = vc.scores

        //updates player count, segues if limit is met
        playerCount = playerCount+1
        if playerCount>3{
            performSegue(withIdentifier: "toScoreScreen", sender: self)
            return
        }
        setUpPlayerCounter()
        
        //deselects selected row
        tableview.deselectRow(at: path, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreScreen" {
            let controller = segue.destination as! ScoreScreen
            controller.scores = scores
            controller.deck = deck
        }
    }
    
    func setUpEnter(){
        //adding to view
        view.addSubview(enter)
        
        //setting up properties
        enter.setTitle("  Enter  ", for: .normal)
        
        enter.backgroundColor = UIColor.blue
        enter.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        enter.titleLabel?.font = UIFont(name: "CourierNewPSMT", size: 30)
        enter.layer.cornerRadius = 20
        
        //constraints
        enter.translatesAutoresizingMaskIntoConstraints = false
        enter.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        enter.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    
    func setUpDefinition(){
        //adding to view
        view.addSubview(definitionLabel)
        
        //setting up properties
        definitionLabel.text = "\(definition)"
        definitionLabel.textColor = UIColor.black
        definitionLabel.font = UIFont(name: "CourierNewPSMT", size: 20)
        definitionLabel.adjustsFontSizeToFitWidth = true
        
        //constraints
        definitionLabel.preferredMaxLayoutWidth = view.frame.width-60
        definitionLabel.numberOfLines = 0
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        definitionLabel.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }

//TABLE VIEW FUNCTIONS

    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //number of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termArray.count
    }
    
    //sends cell data to fill in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TermCell
        cell.backgroundColor = UIColor.white
        cell.termLabel.text = "\(termArray[indexPath.row].text)"
        cell.termLabel.font = UIFont(name: "CourierNewPSMT", size: 30)
        
        var num = Int.random(in: 1...5)
        if(num == 1){
            cell.termLabel.textColor = UIColor.yellow
        }
        else if(num == 2){
            cell.termLabel.textColor = UIColor.green
        }
        else if(num == 3){
            cell.termLabel.textColor = UIColor.orange
        }
        else if(num == 4){
            cell.termLabel.textColor = UIColor.red
        }
        else{
            cell.termLabel.textColor = UIColor.blue
        }
        
        cell.playerKey=termArray[indexPath.row].player
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath) as! TermCell
        if cell.playerKey==playerCount{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //sets up tableview to later be displayed kinda, dont really know how this one works or why we need it but im too scared to touch it
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.separatorColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //set up table view class
    func setupTableView() {
        //register is really important
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(TermCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        //constraints
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpDefinition()
        setUpPlayerCounter()
        setUpEnter()
    }
}


//CELL FUNCTIONS
class TermCell: UITableViewCell {
    
//playerkey is a funny idea i had to keep track of who did what cell
//If its 0 then its the right answer, all other numbers are mapped to a player
//-1 means something is wrong
    
    var playerKey = -1
    
    //initializes the cells when called in table i think
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    //All the important cell constraints
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(termLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        termLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        termLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        termLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        termLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
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
    
    //Cell text properties, if you ever get a buhhhh something is wrong, big thinkin' ja feel?
    let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Buhhhh"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //no idea
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
