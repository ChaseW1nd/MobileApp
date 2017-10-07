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
    
    @IBOutlet weak var currentLocationField: UITextField!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial countdown duration as 10 mins (600 s)
        datePicker.countDownDuration = 600
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
        }
        
        // TODO: Pass the selected emergency contact to next controller
    }
    
    
    // MARK: Actions
    
    @IBAction func getLocation(_ sender: UIButton){
        
        currentLocationField.isHidden = false
        toLabel.isHidden = false
        destinationField.isHidden = false
        
    }
    
    @IBAction func chooseContact(_ sender: UIButton) {
        contactLabel.isHidden = false

    }
    

    
    

    

}
