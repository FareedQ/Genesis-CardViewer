//
//  card.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
//import Foundation
import CoreData
//
//class Card : ImageFromURLFetcher {
//    let id:Int
//    let rarity:String
//    let card_number:Int
//    let name:String
//    let affiliation:String
//    let type:String
//    let awareness:String
//    let rule_text:String
//    let artist:String
//    let set:String
//    let created_at:String
//    let updated_at:String
//    let number:Int
//    let supertype:String
//
//    var flavour_text:String?
//    var health:String?
//    var energy:Int?
//    var aura:Int?
//    var chi:Int?
//
//    init(id: Int, rarity: String, card_number: Int, name: String, affiliation: String, type: String, awareness: String, rule_text: String, artist: String, set: String, created_at: String, updated_at: String, number: Int, supertype: String) {
//        self.id = id
//        self.rarity = rarity
//        self.card_number = card_number
//        self.name = name
//        self.affiliation = affiliation
//        self.type = type
//        self.awareness = awareness
//        self.rule_text = rule_text
//        self.artist = artist
//        self.set = set
//        self.created_at = created_at
//        self.updated_at = updated_at
//        self.number = number
//        self.supertype = supertype
//    }
//}

extension Card {
    
    static func save(id: Int, name: String, rarity: String, card_number: Int, affiliation: String, type: String, awareness: String, rule_text: String, artist: String, set: String, created_at: String, updated_at: String, number: Int, supertype: String) -> Card {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Card() }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: managedContext)!
        
        let card = Card(entity: entity, insertInto: managedContext)
        
        card.setValue(id, forKeyPath: "id")
        card.setValue(name, forKeyPath: "name")
        card.setValue(rarity, forKeyPath: "rarity")
        card.setValue(card_number, forKeyPath: "card_number")
        card.setValue(affiliation, forKeyPath: "affiliation")
        card.setValue(type, forKeyPath: "type")
        card.setValue(awareness, forKeyPath: "awareness")
        card.setValue(rule_text, forKeyPath: "rule_text")
        card.setValue(artist, forKeyPath: "artist")
        card.setValue(set, forKeyPath: "set")
        card.setValue(created_at, forKeyPath: "created_at")
        card.setValue(updated_at, forKeyPath: "updated_at")
        card.setValue(number, forKeyPath: "number")
        card.setValue(supertype, forKeyPath: "supertype")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return card
    }
    
    func addImageData(_ imageData: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(imageData, forKey: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
