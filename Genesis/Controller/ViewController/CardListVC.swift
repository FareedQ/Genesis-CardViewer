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

    //Set a selectedCard variable to be able to be passed to the detail view
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
        
        selectedCard = indexPath.row
        self.performSegue(withIdentifier: "image", sender: self)
    }
}

extension CardListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterOption", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row % 3 == 0 {
            cell.backgroundColor = UIColor.green
        } else if indexPath.row % 3 == 1 {
            cell.backgroundColor = UIColor.blue
        } else {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    
}
