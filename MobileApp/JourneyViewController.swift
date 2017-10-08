//
//  JourneyViewController.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class JourneyViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var destinationLabel: UILabel!
    
    // Contact information.
    var name = ""
    var phone = ""
    var target = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial countdown duration as 20 mins (1200 s)
        datePicker.countDownDuration = 1200
        
        // Read data from tab bar controller
        let mainController = self.tabBarController as! MainViewController
        name = mainController.name
        phone = mainController.phone
        target = mainController.targetLocation
        
        // Hide contact label when no contact is choosen
        if name != "" {
            contactLabel.isHidden = false
            contactLabel.text = name
        } else {
            contactLabel.isHidden = true
        }
        
        // Hide location labels when no location is choosen
        if target != "" {
            destinationLabel.isHidden = false
            destinationLabel.text = target
        } else {
            destinationLabel.isHidden = true
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the selected countdown time to next controller
        if segue.identifier == "startJourney" {
            let nextController = segue.destination as! InJourneyViewController
            // Pass the number of minutes
            nextController.time = Int(datePicker.countDownDuration) / 60
            // Pass the contact number
            nextController.contactPhone = phone
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func getLocation(_ sender: UIButton){
        
    }
    
    @IBAction func chooseContact(_ sender: UIButton) {

    }

}
