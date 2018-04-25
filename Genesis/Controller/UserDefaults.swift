//
//  UserDefaults.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-25.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func hasSeenDisclaimer() -> Bool {
        let seen = UserDefaults.standard.bool(forKey: "disclaimer")
        if seen {
            return true
        } else {
            UserDefaults.standard.set(true, forKey: "disclaimer")
            return false
        }
    }
}
