//
//  Contact.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class Contact {
    
    //MARK: Properties
    
    var name: String
    var username: String
    var phone: String
    
    //MARK: Initialization
    
    init?(name: String, username: String, phone: String) {
        
        // The username must not be empty
        guard !username.isEmpty else {
            return nil
        }
        
        // TODO: The phone number must be made up of 10-digit numbers
        
        // Initialize stored properties.
        self.name = name
        self.username = username
        self.phone = phone
    }
    
}
