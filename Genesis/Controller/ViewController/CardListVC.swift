//
//  ViewController.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit
import Alamofire

class CardListVC: UIViewController {

    fileprivate var selectedCard = 0
    
    @IBOutlet weak var tblInformation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            if let destinationView = segue.destination as? ImageDetailVC {
                destinationView.selectedCard = selectedCard
            }
        }
    }


}

extension CardListVC : UITableViewDelegate, UITableViewDataSource {
    
    
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
        
//        let loaded = Bundle.main.loadNibNamed("Card", owner: self, options: nil)
//        let popUP = loaded?[0] as! CardView
//        popUP.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//        popUP.center = self.view.center
//        popUP.clipsToBounds = true
//        popUP.layer.cornerRadius = 10
//        popUP.layer.borderWidth = 2
//        popUP.layer.borderColor = UIColor.gray.cgColor
//        //popUP.imgCard.downloadedFrom(url: URL(string: AppSession.shared.cards[indexPath.row].picture)!)
//        self.view.addSubview(popUP)
//        UIView.animate(withDuration: 0.3, animations: {
//            popUP.bounds = CGRect(x: 0, y: 0, width: 220, height: 320)
//        }) { _ in
//            UIView.animate(withDuration: 0.1, animations: {
//                popUP.bounds = CGRect(x: 0, y: 0, width: 200, height: 300)
//            }) { _ in
//                popUP.fadeIn()
//            }
//        }
        
        selectedCard = indexPath.row
        self.performSegue(withIdentifier: "image", sender: self)
    }
    
}

