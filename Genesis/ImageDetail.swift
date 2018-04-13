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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imgCard.downloadedFrom(url: URL(string: AppSession.shared.cards[selectedCard].picture)!)
    }
    
}
