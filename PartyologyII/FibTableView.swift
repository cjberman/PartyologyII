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
    var definition: String = ""
    var termArray = [String]()
    var definitionLabel = UILabel()
    var playerCounter = UILabel()
    var playerCount = 1
    let enter = UIButton()
    
    func setUpPlayerCounter(){
        //adding to view
        view.addSubview(playerCounter)
        
        //setting up properties
        playerCounter.text = "Player \(playerCount)"
        playerCounter.textColor = UIColor.red
        playerCounter.font = UIFont(name: "Helvetica Neue", size: 30)
        playerCounter.adjustsFontSizeToFitWidth = true
        
        //constraints
        playerCounter.translatesAutoresizingMaskIntoConstraints = false
        playerCounter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        playerCounter.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
    @objc func enterButton(){
        
        
        guard let path = tableview.indexPathForSelectedRow else {return}
        
        print(path.row)
        playerCount = playerCount+1
        setUpPlayerCounter()
        
        //deselects selected row
        
        tableview.deselectRow(at: path, animated: false)
        
    
    }
            
    
    func setUpEnter(){
        //adding to view
        view.addSubview(enter)
        
        //setting up properties
        enter.setTitle("  Enter  ", for: .normal)
        enter.setTitleColor(UIColor.white, for: .normal)
        enter.backgroundColor = UIColor.red
        enter.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        enter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
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
        definitionLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        definitionLabel.adjustsFontSizeToFitWidth = true
        
        //constraints
        definitionLabel.preferredMaxLayoutWidth = view.frame.width-60
        definitionLabel.numberOfLines = 0
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        definitionLabel.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TermCell
        cell.backgroundColor = UIColor.white
        cell.termLabel.text = "\(termArray[indexPath.row])"
        return cell
    }
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.separatorColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(TermCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    

    override func viewDidLoad() {
        let vc = FibbageViewController(nibName: "FibbageViewController", bundle: nil)
        //termArray = vc.termsArray
        print(vc.termsArray)
        super.viewDidLoad()
        setupTableView()
        setUpDefinition()
        setUpPlayerCounter()
        setUpEnter()
    }
}

class TermCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
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
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Buhhhh"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
