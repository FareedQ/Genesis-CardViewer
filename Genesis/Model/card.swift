//
//  card.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
import Foundation

class Card : urlImageObject {
    let id:Int
    let rarity:String
    let card_number:Int
    let name:String
    let affiliation:String
    let type:String
    let awareness:String
    let rule_text:String
    let artist:String
    let set:String
    let created_at:String
    let updated_at:String
    let number:Int
    let supertype:String
    
    var flavour_text = ""
    var health = 0
    var energy = 0
    var aura = 0
    var chi = 0
    
    init(id: Int, rarity: String, card_number: Int, name: String, affiliation: String, type: String, awareness: String, rule_text: String, artist: String, set: String, created_at: String, updated_at: String, number: Int, supertype: String) {
        self.id = id
        self.rarity = rarity
        self.card_number = card_number
        self.name = name
        self.affiliation = affiliation
        self.type = type
        self.awareness = awareness
        self.rule_text = rule_text
        self.artist = artist
        self.set = set
        self.created_at = created_at
        self.updated_at = updated_at
        self.number = number
        self.supertype = supertype
    }
}
