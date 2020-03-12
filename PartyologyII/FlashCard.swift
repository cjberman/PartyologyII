//
//  FlashCard.swift
//  PartyologyII
//
//  Created by Alexander Levinson (student LM) on 2/25/20.
//  Copyright © 2020 Charles Berman (student LM). All rights reserved.
//

import Foundation

class FlashCard: Codable{
    var term: String
    var definition: String
    
    init(_ term: String = "default term", _ definition: String = "default definition"){
        self.term = term
        self.definition = definition
    }
    
    //use .description to print a flashcard
    public var description: String{
        return "\(term): \(definition)"
    }
    
}

