//
//  ImageDetail.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

class ImageDetailVC: UIViewController {
    
    @IBOutlet weak var imgCard: UIImageView!
    
    var selectedCard = 0
    
    override func viewDidLoad() {
        guard let imageData = AppSession.shared.cards[selectedCard].value(forKeyPath: "image") as? Data,
            let image = UIImage(data: imageData) else {
                imgCard.image = UIImage(named: "default_card")
                return
        }
        imgCard.image = image
    }
    
}
