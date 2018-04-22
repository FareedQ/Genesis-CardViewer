//
//  HeroSelectorVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-21.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit
import CoreData

class HeroSelector: UIViewController {
    
    let championPredicate = NSPredicate(format: "supertype = 'Champion'")
    
    override func viewDidLoad() {
        
        //Load the Champion cards from CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        fetchRequest.predicate = championPredicate
        let championcards = try? managedContext.fetch(fetchRequest) as! [Card]
        for card in championcards! {
            if let name = card.value(forKeyPath: "name") as? String {
                print(name)
            }
        }
    }
    
}
