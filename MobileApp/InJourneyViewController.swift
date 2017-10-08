//
//  InJourneyViewController.swift
//  MobileApp
//
//  Created by ellen on 7/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import EZAudio

class InJourneyViewController: UIViewController, EZMicrophoneDelegate {

    // MARK: Properties
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var time: Int!
    var totalSecs: Int!
    var timer: Timer!
    var contactPhone = ""
    
    var microphone: EZMicrophone!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the countdown and labels
        totalSecs = time * 60
        updateTimeLabels(valueHour: time / 60, valueMin: time % 60, valueSec: 0)
        
        // Use Timer to update remaining time and labels
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
        
        // FIXME: Print for testing
        print(contactPhone)
        
        // Initialize the microphone
        microphone = EZMicrophone(delegate: self, startsImmediately: false);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // TODO: Remove this test for tab navigation
        if segue.identifier == "test" {
            let nextController = segue.destination as! MainViewController
            nextController.selectedIndex = 0
            
        }
        
    }
    

    // MARK: Actions
    
    // Add some minutes choosing from a list.
    @IBAction func addMoreMins(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "How long do you wanna add?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "2 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 120 }))
        alert.addAction(UIAlertAction(title: "5 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 300 }))
        alert.addAction(UIAlertAction(title: "10 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 600 }))
        alert.addAction(UIAlertAction(title: "30 mins", style: .default, handler: { (action) in
            self.totalSecs = self.totalSecs + 1800 }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // Start recording.
    @IBAction func autoRecordButton(_ sender: UIButton) {
        
        microphone.startFetchingAudio()
        print("Start")
        
    }
    
    func microphone(_ microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        DispatchQueue.main.async(execute: { () -> Void in
            //self.plot?.updateBuffer(buffer[0], withBufferSize: bufferSize);
            print("0=========== \(buffer[0])")
            print("1=========== \(buffer[1])")
        });
    }
    
    // Calculate the remaining time.
    func tickDown() {
        
        totalSecs = totalSecs - 1
        updateTimeLabels(valueHour: totalSecs / 3600,
                         valueMin: (totalSecs % 3600) / 60,
                         valueSec: totalSecs % 60 )
        
        // Check if timeout.
        if totalSecs == 0 {
            
            // Send notification.
            
            
        }
        
        
    }
    
    // Update labels.
    func updateTimeLabels(valueHour: Int, valueMin: Int, valueSec: Int){
        
        hourLabel.text = String(valueHour)
        minLabel.text = String(valueMin)
        secLabel.text = String(valueSec)
        
    }
    
}
