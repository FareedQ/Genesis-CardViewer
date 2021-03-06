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
    
    func loadAllCards(update:@escaping (String)-> (), success:@escaping ()->()){
        Alamofire.request("http://genesis-online.herokuapp.com/cards", method: .get).responseJSON{ response in
            
            if let json = response.result.value as? [String:[String:Any]] {
                
                var countedCardsWithImagesLoaded = 0 //This may be confusing. It is explained below.
                

                for item in json {
                    
                    //Loads CoreData Cards with data endpoints that are known
                    guard let id = item.value["id"] as? Int,
                        let rarity = item.value["rarity"] as? String,
                        let card_number = item.value["card_number"] as? Int,
                        let name = item.value["name"] as? String,
                        let affiliation = item.value["affiliation"] as? String,
                        let type = item.value["type"] as? String,
                        let awareness = item.value["awareness"] as? String,
                        let rule_text = item.value["rule_text"] as? String,
                        let artist = item.value["artist"] as? String,
                        let imageURL = item.value["picture"] as? String,
                        let set = item.value["set"] as? String,
                        let created_at = item.value["created_at"] as? String,
                        let updated_at = item.value["updated_at"] as? String,
                        let number = item.value["number"] as? Int,
                        let supertype = item.value["supertype"] as? String else {
                            print("Failed to load item at \(item.key)")
                            continue
                    }
                    let thisCard = Card.save(id: id, name: name, rarity: rarity, card_number: card_number, affiliation: affiliation, type: type, awareness: awareness, rule_text: rule_text, artist: artist, set: set, created_at: created_at, updated_at: updated_at, number: number, supertype: supertype, imageURL: imageURL)
                    
                    //Goes through and inserts any endpoints that are possible
                    if let health = item.value["health"] as? String {
                        thisCard.insert(health: health)
                    }
                    if let chi = item.value["chi"] as? Int {
                        thisCard.insert(chi: chi)
                    }
                    if let energy = item.value["energy"] as? Int {
                        thisCard.insert(energy: energy)
                    }
                    if let aura = item.value["aura"] as? Int {
                        thisCard.insert(aura: aura)
                    }
                    if let flavour_text = item.value["flavour_text"] as? String {
                        thisCard.insert(flavour_text: flavour_text)
                    }
                    
                    
                    
                    //This snippet is to promise after all images are loaded then it will stat this load is a success
                    self.returnImageData(for: imageURL, complete: { imageData in
                        thisCard.insert(imageData: imageData)
                        countedCardsWithImagesLoaded += 1
                        update("\(countedCardsWithImagesLoaded) of \(json.count)")
                        if countedCardsWithImagesLoaded == json.count {
                            success()
                        }
                    })
                    
                    
                }
                
            }
        }
    }
    
    //Function for loading the Data from the image URL
    func returnImageData(for URLString:String, complete:@escaping(Data)->()) {
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    complete(Data())
                    return
                }
                if let data = data {
                    complete(data)
                }
            }).resume()
        }
        
    }
}
