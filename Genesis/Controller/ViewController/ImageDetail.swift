//
//  ImageDetail.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

class ImageDetail: UIViewController {
    
    @IBOutlet weak var imgCard: UIImageView!
    
    var selectedCard = 0
    
    override func viewDidLoad() {
        imgCard.image = AppSession.shared.cards[selectedCard].image
    }
    
}
