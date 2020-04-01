//
//  ScoreScreen.swift
//  PartyologyII
//
//  Created by Julius Murphy (student LM) on 4/1/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import UIKit
import Foundation

class ScoreScreen: UIViewController, UITableViewDelegate,  UITableViewDataSource{
    let header = UILabel()
    var scores = [Int:Int]()
    
    
    func setUpHeader(){
        //adding to view
        view.addSubview(header)
        
        //setting up properties
        header.text = "Scores:"
        header.textColor = UIColor.black
        header.font = UIFont(name: "Helvetica Neue", size: 75)
        header.adjustsFontSizeToFitWidth = true
        
        //constraints
        header.preferredMaxLayoutWidth = view.frame.width-60
        header.numberOfLines = 0
        header.translatesAutoresizingMaskIntoConstraints = false
        header.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        header.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        header.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

//TABLE STUFF
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //number of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    //sends cell data to fill in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ScoreCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.termLabel.text = "Player \(indexPath.row+1): \((scores[indexPath.row+1]) ?? -99)"
        return cell
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
        tableview.register(ScoreCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        //constraints
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpHeader()
        print(scores)
    }
    
}

//CELL FUNCTIONS
class ScoreCell: UITableViewCell {
    

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
        termLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
    }
    
    //Cell background properties
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //no idea
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
