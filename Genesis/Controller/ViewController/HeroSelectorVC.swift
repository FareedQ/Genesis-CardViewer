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
    var championcards = [Card]()
    
    @IBOutlet weak var currentCardView: CardView!
    
    override func viewDidLoad() {
        
        //Load the Champion cards from CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        fetchRequest.predicate = championPredicate
        championcards = try! managedContext.fetch(fetchRequest) as! [Card]
        for card in championcards {
            if let name = card.value(forKeyPath: "name") as? String {
                print(name)
            }
        }
        
        let loadedCard = loadCard(index: 0)
        self.currentCardView?.addSubview(loadedCard)
    }
    
    func loadCard(index: Int) -> CardView {
        let loaded = Bundle.main.loadNibNamed("Card", owner: self, options: nil)
        let card = loaded?[0] as! CardView
        card.frame = currentCardView.bounds
        
        
        if let cardImageData = championcards[index].value(forKey: "image") as? Data {
            let cardImage = UIImage(data: cardImageData)
            card.imgCard.image = cardImage
        }
        
        card.layer.borderWidth = 1
        card.layoutIfNeeded()
        
        return card
    }
    
}
