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
    @IBOutlet weak var currentCardY: NSLayoutConstraint!
    @IBOutlet weak var currentCardX: NSLayoutConstraint!
    var originalTouch = CGPoint.zero
    
    override func viewDidLoad() {
        
        //Load the Champion cards from CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        fetchRequest.predicate = championPredicate
        championcards = try! managedContext.fetch(fetchRequest) as! [Card]
        
        //Set current card as the 0 card in the index
        let loadedCard = loadCard(index: 0)
        self.currentCardView?.addSubview(loadedCard)
        
        //Add guesture recongizer for tinder controls
        let guestureRecongizer = UIPanGestureRecognizer(target: self, action: #selector(selectedOption))
        currentCardView?.addGestureRecognizer(guestureRecongizer)
    }
    
    private func loadCard(index: Int) -> CardView {
        let loaded = Bundle.main.loadNibNamed("Card", owner: self, options: nil)
        let card = loaded?[0] as! CardView
        card.frame = currentCardView.bounds
        
        if let cardImageData = championcards[index].value(forKey: "image") as? Data {
            let cardImage = UIImage(data: cardImageData)
            card.imgCard.image = cardImage
        }
        
        return card
    }
    
    
    //MARK: Guesture Recongizer Code
    @objc func selectedOption(sender: UIPanGestureRecognizer){
        let myTouchInEntireView = sender.location(in: view)
        
        switch sender.state {
        case .began:
            setOriginalTouch(sender)
            break
            
        case .changed:
            let xOffset = getXOffset(myTouchInEntireView)
            let yOffset = getYOffset(myTouchInEntireView)
            let angle = getOffsetAngle(myTouchInEntireView)
            
            movingCard(xOffset: xOffset, yOffset: yOffset, angle: angle)
            
            break
            
        case .ended:
            putCardBack()
            break
        default:
            break
            
        }
    }
    
    private func setOriginalTouch(_ sender: UIPanGestureRecognizer){
        guard let currentView = currentCardView else { return }
        let myTouchInCurrentView = sender.location(in: currentView)
        originalTouch = CGPoint(x: myTouchInCurrentView.x - currentView.frame.width/2, y: myTouchInCurrentView.y - currentView.frame.height/2)
    }
    
    private func movingCard(xOffset:CGFloat, yOffset:CGFloat, angle:CGFloat){
        currentCardX.constant = xOffset
        currentCardY.constant = yOffset
        currentCardView?.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    private func getXOffset(_ touch:CGPoint) -> CGFloat {
        return (touch.x - view.frame.width/2) - originalTouch.x
    }
    
    private func getYOffset(_ touch:CGPoint) -> CGFloat {
        return (touch.y - view.frame.height/2) - originalTouch.y
    }
    
    private func getOffsetAngle(_ touch:CGPoint) -> CGFloat {
        return (touch.x - view.frame.width/2) / view.frame.width/2
    }
    
    private func putCardBack() {
        UIView.animate(withDuration: 0.3, animations: {
            self.currentCardX.constant = 0
            self.currentCardY.constant = 0
            self.currentCardView?.transform = CGAffineTransform(rotationAngle: 0)
            self.view.layoutIfNeeded()
        })
    }
    
}
