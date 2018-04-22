//
//  card.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
import CoreData

// An extension on the Card coredata object

extension Card {
    
    static func save(id: Int, name: String, rarity: String, card_number: Int, affiliation: String, type: String, awareness: String, rule_text: String, artist: String, set: String, created_at: String, updated_at: String, number: Int, supertype: String, imageURL: String) -> Card {
        
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
        card.setValue(imageURL, forKeyPath: "image_url")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return card
    }
    
    func insert(imageData: Data) {
        dispatchMain {
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
    
    func insert(health: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(health, forKey: "health")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insert(chi: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(chi, forKey: "chi")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insert(energy: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(energy, forKey: "energy")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insert(aura: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(aura, forKey: "aura")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insert(flavour_text: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.setValue(flavour_text, forKey: "flavour_text")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
