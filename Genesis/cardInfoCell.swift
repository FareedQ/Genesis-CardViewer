//
//  cardInfoCell.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

class CardInfoCell: UITableViewCell {
    
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
        lblName.text = "Name: \(card.name)"
        lblCardNumber.text = "Card Number: \(card.card_number)"
        lblAffiliation.text = "Affiliation: \(card.affiliation)"
        lblType.text = "Type: \(card.type)"
        lblHealth.text = "Health: \(card.health)"
        lblAwareness.text = "Awareness: \(card.awareness)"
        lblFalvourText.text = "Flavour Text: \(card.flavour_text)"
        lblArtist.text = "Artist: \(card.artist)"
        lblSet.text = "Set: \(card.set)"
    }
    
}
