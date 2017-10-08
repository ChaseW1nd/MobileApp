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
        
        if name != "" {
            UserDefaults.standard.set(name, forKey: "contactName")}
        if target != "" {
            UserDefaults.standard.set(target, forKey: "destination")}
        if phone != "" {
            UserDefaults.standard.set(target, forKey: "contactPhone")}
        
        contactLabel.text = UserDefaults.standard.string(forKey: "contactName")
        destinationLabel.text = UserDefaults.standard.string(forKey: "destination")
        
        // Disable start button if no info is choosen
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected countdown time to next controller
        if segue.identifier == "startJourney" {
            let nextController = segue.destination as! InJourneyViewController
            // Pass the number of minutes
            nextController.time = Int(datePicker.countDownDuration) / 60
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func getLocation(_ sender: UIButton){
    }
    
    @IBAction func chooseContact(_ sender: UIButton) {
    }

}
