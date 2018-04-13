//
//  ViewController.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var selectedCard = 0
    
    @IBOutlet weak var tblInformation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://genesis-online.herokuapp.com/cards.json", method: .get).responseJSON{ response in
            
            if let json = response.result.value as? [String:[String:Any]] {
                for item in json {
                    guard let id = item.value["id"] as? Int,
                        let rarity = item.value["rarity"] as? String,
                        let card_number = item.value["card_number"] as? Int,
                        let name = item.value["name"] as? String,
                        let affiliation = item.value["affiliation"] as? String,
                        let type = item.value["type"] as? String,
                        let health = item.value["health"] as? String,
                        let awareness = item.value["awareness"] as? String,
                        let rule_text = item.value["rule_text"] as? String,
                        let flavour_text = item.value["flavour_text"] as? String,
                        let artist = item.value["artist"] as? String,
                        let picture = item.value["picture"] as? String,
                        let set = item.value["set"] as? String,
                        let created_at = item.value["created_at"] as? String,
                        let updated_at = item.value["updated_at"] as? String,
                        let number = item.value["number"] as? Int,
                        let supertype = item.value["supertype"] as? String else {
                            print("Failed to load item at \(item.key)")
                            continue
                    }
                    
                    var card = Card(id: id, rarity: rarity, card_number: card_number, name: name, affiliation: affiliation, type: type, health: health, awareness: awareness, rule_text: rule_text, flavour_text: flavour_text, artist: artist, picture: picture, set: set, created_at: created_at, updated_at: updated_at, number: number, supertype: supertype, energy: 0, aura: 0, chi: 0)
                    
                    if let chi = item.value["chi"] as? Int {
                        card.chi = chi
                    }
                    if let energy = item.value["energy"] as? Int {
                        card.energy = energy
                    }
                    if let aura = item.value["aura"] as? Int {
                        card.aura = aura
                    }
                    AppSession.shared.cards.append(card)
                }
            }
            self.tblInformation.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image" {
            if let destinationView = segue.destination as? ImageDetail {
                destinationView.selectedCard = selectedCard
            }
        }
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppSession.shared.cards.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as? CardInfoCell else {
            return UITableViewCell()
        }
        cell.configureCell(card: AppSession.shared.cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let loaded = Bundle.main.loadNibNamed("Card", owner: self, options: nil)
        let popUP = loaded?[0] as! CardView
        popUP.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        popUP.center = self.view.center
        popUP.clipsToBounds = true
        popUP.layer.cornerRadius = 10
        popUP.layer.borderWidth = 2
        popUP.layer.borderColor = UIColor.gray.cgColor
        popUP.imgCard.downloadedFrom(url: URL(string: AppSession.shared.cards[indexPath.row].picture)!)
        self.view.addSubview(popUP)
        UIView.animate(withDuration: 0.3, animations: {
            popUP.bounds = CGRect(x: 0, y: 0, width: 220, height: 320)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                popUP.bounds = CGRect(x: 0, y: 0, width: 200, height: 300)
            }) { _ in
                popUP.fadeIn()
            }
        }
        
//        selectedCard = indexPath.row
//        self.performSegue(withIdentifier: "image", sender: self)
    }
    
}

