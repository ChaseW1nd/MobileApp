//
//  User.swift
//  MobileApp
//
//  Created by ellen on 4/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class User {
    
    //MARK: Properties
    
    var username: String
    var password: String
    var name: String
    var phone: String
    
    //MARK: Initialization
    
    init?(username: String, password: String, name: String, phone: String) {
        
        // The username must not be empty
        guard !username.isEmpty else {
            return nil
        }
        
        // TODO: The phone number must be made up of 10-digit numbers
        
        // Initialize stored properties.
        self.username = username
        self.password = password
        self.name = name
        self.phone = phone
    }
}
