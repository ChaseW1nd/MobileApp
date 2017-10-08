//
//  MainViewController.swift
//  MobileApp
//
//  Created by ellen on 8/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // Contact information.
    var name = ""
    var username = ""
    var phone = ""
    
    // Location information.
    var currentLocation = ""
    var targetLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
