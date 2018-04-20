//
//  cardInfoCell.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
import CoreData

class CardInfoCell: UITableViewCell {
    
    @IBOutlet weak var imgCardPicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblAffiliation: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblHealth: UILabel!
    @IBOutlet weak var lblAwareness: UILabel!
    @IBOutlet weak var lblFalvourText: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSet: UILabel!
    
    func configureCell(card:NSManagedObject){
        
        if let imageData = card.value(forKeyPath: "image") as? Data,
            let image = UIImage(data: imageData) {
            imgCardPicture.image = image
        } else {
            imgCardPicture.image = UIImage(named: "default_card")
        }
        
        
        if let name = card.value(forKeyPath: "name") as? String {
            lblName.text = name
        }
        if let card_number = card.value(forKeyPath: "card_number") as? Int {
            lblCardNumber.text = "Card Number: \(card_number)"
        }
        if let affiliation = card.value(forKeyPath: "affiliation") as? String {
            lblAffiliation.text = "Affiliation: \(affiliation)"
        }
        if let type = card.value(forKeyPath: "type") as? String {
            lblType.text = "Type: \(type)"
        }
        if let health = card.value(forKeyPath: "health") as? String {
            lblHealth.text = "Health: \(health)"
        }
        if let flavour_text = card.value(forKeyPath: "flavour_text") as? String {
            lblFalvourText.text = "Flavour Text: \(flavour_text)"
        }
        if let awareness = card.value(forKeyPath: "awareness") as? String {
            lblHealth.text = "Awareness: \(awareness)"
        }
        if let artist = card.value(forKeyPath: "artist") as? String {
            lblArtist.text = "Artist: \(artist)"
        }
        if let set = card.value(forKeyPath: "set") as? String {
            lblSet.text = "Set: \(set)"
        }
        
        self.selectionStyle = .none
    }
    
}
