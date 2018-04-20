//
//  cardInfoCell.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

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
    
    func configureCell(card:Card){
        imgCardPicture.image = card.image
        lblName.text = "Name: \(card.name)"
        lblCardNumber.text = "Card Number: \(card.card_number)"
        lblAffiliation.text = "Affiliation: \(card.affiliation)"
        lblType.text = "Type: \(card.type)"
        if let healthText = card.health {
            lblHealth.text = "Health: \(healthText)"
        }
        if let flavour_text = card.flavour_text {
            lblFalvourText.text = "Flavour Text: \(flavour_text)"
        }
        lblAwareness.text = "Awareness: \(card.awareness)"
        lblArtist.text = "Artist: \(card.artist)"
        lblSet.text = "Set: \(card.set)"
        
        self.selectionStyle = .none
    }
    
}
