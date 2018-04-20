//
//  Alerts.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-20.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private func alertMessage(title:String, message:String, okay: @escaping ()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) {
            (a:UIAlertAction) -> Void in
            okay()
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true) { }
    }
    
    private func alertMessage(title:String, message:String, okay: @escaping ()->(), cancel: @escaping ()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) {
            (a:UIAlertAction) -> Void in
            okay()
        }
        alert.addAction(okayAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (a:UIAlertAction) -> Void in
            cancel()
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true) { }
    }
    
    func alertSystemError(action:@escaping()->()){
        alertMessage(title: "System Error", message: "There was a system error. We have noted it. The app may behave incorrectly.") {
            action()
        }
    }
}
