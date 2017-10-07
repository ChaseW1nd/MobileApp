//
//  InJourneyViewController.swift
//  MobileApp
//
//  Created by ellen on 7/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit

class InJourneyViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var time: Int!
    var totalSecs: Int!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the countdown and labels
        totalSecs = time * 60
        updateTimeLabels(valueHour: time / 60, valueMin: time % 60, valueSec: 0)
        
        // Use Timer to update remaining time and labels
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
        
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

    // MARK: Actions
    
    @IBAction func addMoreMins(_ sender: UIButton) {
        
        // Add some minutes choosing from a list.
        let alert = UIAlertController(title: "How long do you wanna add?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "2 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 120 }))
        alert.addAction(UIAlertAction(title: "5 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 300 }))
        alert.addAction(UIAlertAction(title: "10 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 600 }))
        alert.addAction(UIAlertAction(title: "30 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 1800 }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func tickDown() {
        
        totalSecs = totalSecs - 1
        updateTimeLabels(valueHour: totalSecs / 3600,
                         valueMin: (totalSecs % 3600) / 60,
                         valueSec: totalSecs % 60 )
        
    }
    
    func updateTimeLabels(valueHour: Int, valueMin: Int, valueSec: Int){
        
        hourLabel.text = String(valueHour)
        minLabel.text = String(valueMin)
        secLabel.text = String(valueSec)
        
    }
    
}
