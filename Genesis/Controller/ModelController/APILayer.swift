//
//  APILayer.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import Alamofire

class APILayer {
    static let shared = APILayer()
    
    func loadAllCards(success:@escaping ()->()){
        Alamofire.request("http://genesis-online.herokuapp.com/cards", method: .get).responseJSON{ response in
            
            if let json = response.result.value as? [String:[String:Any]] {
                for item in json {
                    guard let id = item.value["id"] as? Int,
                        let rarity = item.value["rarity"] as? String,
                        let card_number = item.value["card_number"] as? Int,
                        let name = item.value["name"] as? String,
                        let affiliation = item.value["affiliation"] as? String,
                        let type = item.value["type"] as? String,
                        let awareness = item.value["awareness"] as? String,
                        let rule_text = item.value["rule_text"] as? String,
                        let artist = item.value["artist"] as? String,
                        let pictureString = item.value["picture"] as? String,
                        let set = item.value["set"] as? String,
                        let created_at = item.value["created_at"] as? String,
                        let updated_at = item.value["updated_at"] as? String,
                        let number = item.value["number"] as? Int,
                        let supertype = item.value["supertype"] as? String else {
                            print("Failed to load item at \(item.key)")
                            continue
                    }
                    
                    
                    let card = Card(id: id, rarity: rarity, card_number: card_number, name: name, affiliation: affiliation, type: type, awareness: awareness, rule_text: rule_text, artist: artist, set: set, created_at: created_at, updated_at: updated_at, number: number, supertype: supertype)
                    
                    card.loadImageUsingCacheWithURLString(pictureString, placeHolder: UIImage(named: "default_card")!, success: {
                        AppSession.shared.cards.append(card)
                        if AppSession.shared.cards.count == json.count {
                            success()
                        }
                    })
                    
                    if let health = item.value["health"] as? Int {
                        card.health = health
                    }
                    if let chi = item.value["chi"] as? Int {
                        card.chi = chi
                    }
                    if let energy = item.value["energy"] as? Int {
                        card.energy = energy
                    }
                    if let aura = item.value["aura"] as? Int {
                        card.aura = aura
                    }
                    if let flavour_text = item.value["flavour_text"] as? String {
                        card.flavour_text = flavour_text
                    }
                }
            }
        }
    }
    
}
