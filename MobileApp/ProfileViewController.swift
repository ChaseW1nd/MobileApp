//
//  ProfileViewController.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: Properites
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = UserDefaults.standard.string(forKey: "username")
        nameLabel.text = UserDefaults.standard.string(forKey: "userName")
        phoneLabel.text = UserDefaults.standard.string(forKey: "userPhone")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Clean up UserDeafults when logout
        if segue.identifier == "logOut" {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
        }
        
    }

}
