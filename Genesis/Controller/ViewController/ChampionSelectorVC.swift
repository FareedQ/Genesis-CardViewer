//
//  ChampionSelectorVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-21.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit
import CoreData

class ChampionSelector: UIViewController {
    
    let championPredicate = NSPredicate(format: "supertype = 'Champion'")
    var championcards = [Card]()
    
    @IBOutlet weak var currentCardView: CardView!
    @IBOutlet weak var nextCardView: CardView!
    @IBOutlet weak var currentCardY: NSLayoutConstraint!
    @IBOutlet weak var currentCardX: NSLayoutConstraint!
    var originalTouch = CGPoint.zero
    var selectionIndex = 0
    let sideOffset:CGFloat = 45
    
    override func viewDidLoad() {
        
        //Give alert message with tutorial
        self.alertTutorialChampion { }
        
        //Load the Champion cards from CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        fetchRequest.predicate = championPredicate
        championcards = try! managedContext.fetch(fetchRequest) as! [Card]
        
        loadBothCardViews()
        
        //Add guesture recongizer for tinder controls
        let guestureRecongizer = UIPanGestureRecognizer(target: self, action: #selector(selectedOption))
        currentCardView?.addGestureRecognizer(guestureRecongizer)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        self.animateOffScreen(x: -1000, y: 0)
    }
    
    private func loadBothCardViews(){
        self.currentCardView?.addSubview(loadACardView(index: selectionIndex))
        
        if self.selectionIndex != self.championcards.count - 1 {
            self.nextCardView?.addSubview(loadACardView(index: selectionIndex + 1))
        } else {
            // This is to allow cycling of the cards
            self.nextCardView?.addSubview(loadACardView(index: 0))
        }
    }
    
    private func loadACardView(index: Int) -> CardView {
        let loaded = Bundle.main.loadNibNamed("Card", owner: self, options: nil)
        let card = loaded?[0] as! CardView
        card.frame = currentCardView.bounds
        
        if let cardImageData = championcards[index].value(forKey: "image") as? Data {
            let cardImage = UIImage(data: cardImageData)
            card.imgCard.image = cardImage
            card.imgCard.resizeImage(newWidth: currentCardView.bounds.width)
        }
        
        return card
    }
    
    
    //MARK: Guesture Recongizer Code
    @objc func selectedOption(sender: UIPanGestureRecognizer){
        let myTouchInEntireView = sender.location(in: view)
        let xOffset = getXOffset(myTouchInEntireView)
        let yOffset = getYOffset(myTouchInEntireView)
        let angle = getOffsetAngle(myTouchInEntireView)
        
        switch sender.state {
        case .began:
            setOriginalTouch(sender)
            break
            
        case .changed:
            
            movingCard(xOffset: xOffset, yOffset: yOffset, angle: angle)
            
            break
            
        case .ended:
            
            if (xOffset/sideOffset < 0.3) {
                self.animateOffScreen(x: -1000, y: 0)
            } else if (-xOffset/sideOffset < 0.3) {
                self.animateOffScreen(x: 1000, y: 0)
            } else {
                putCardBack()
            }
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
            self.setCardToNormal()
        })
    }
    
    private func setCardToNormal(){
        self.currentCardX.constant = 0
        self.currentCardY.constant = 0
        self.currentCardView?.transform = CGAffineTransform(rotationAngle: 0)
        self.view.layoutIfNeeded()
    }
    
    private func animateOffScreen(x:CGFloat, y:CGFloat){
        UIView.animate(withDuration: 0.3, animations: {
            let angle = self.getOffsetAngle(CGPoint(x: x, y: y))
            self.movingCard(xOffset: x, yOffset: y, angle: angle)
            self.view.layoutIfNeeded()
            self.currentCardView.isHidden = true
        }, completion: { bool in
            self.currentCardView.isHidden = false
            self.selectionIndex += 1
            if self.selectionIndex == self.championcards.count {
                self.selectionIndex = 0
            }
            self.loadBothCardViews()
            self.setCardToNormal()
        })
        self.currentCardView.isHidden = false
    }
    
}
