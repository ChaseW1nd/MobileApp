//
//  InJourneyViewController.swift
//  MobileApp
//
//  Created by ellen on 7/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import EZAudio
import GoogleMaps
import GooglePlaces
import Alamofire

class InJourneyViewController: UIViewController, EZMicrophoneDelegate,GMSMapViewDelegate ,  CLLocationManagerDelegate
   {

    // MARK: Properties
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    
    var time: Int!
    var totalSecs: Int!
    var timer: Timer!
    var contactPhone = ""
    
    var arrive = false
    var microphone: EZMicrophone!;
    
    var googleMapsView: GMSMapView!
    let locationManager = CLLocationManager()
    var x = 1
    
    var recordBool: Bool = false {
        didSet {
            if recordBool {
                audioButton.setTitle("⏹  Stop Recording", for: .normal)
                microphone.startFetchingAudio()
            }else{
                microphone.stopFetchingAudio()
                audioButton.setTitle("🎤  Auto-record voice", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the countdown and labels
        totalSecs = time * 60
        updateTimeLabels(valueHour: time / 60, valueMin: time % 60, valueSec: 0)
        
        // Use Timer to update remaining time and labels
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
        
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
            
        }else if segue.identifier == "arrive" {
            
            self.arrive = true
            let nextController = segue.destination as! MainViewController
            nextController.selectedIndex = 0
            let destination = Bundle.main.bundleIdentifier!
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
        
        recordBool = !recordBool

    }

    func microphone(_ microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        DispatchQueue.main.async(execute: { () -> Void in
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
        
        // Stop sending data when arrived or time out
        if !arrive && totalSecs > 0{
            sendData()
        }else{
            self.locationManager.stopUpdatingLocation()
        }
        
    }
    
    
    // send data to server
    func sendData(){
        
        self.locationManager.startUpdatingLocation()
 
        let latitudeText:String = "-1"
        let longitudeText:String = "-1"
        
        if x > 6{
        let latitudeText:String = "\(self.locationManager.location!.coordinate.latitude)"
        let longitudeText:String = "\(self.locationManager.location!.coordinate)"

        }
        x = x+1
        
        let url = "http://10.13.2.137:8181/location"
        
        let parameters: [String: Any] = [
            "positionX": latitudeText,
            "positionY": longitudeText,
            "sessionId": "2",
            ]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
        }
        
    }
    
    
    // Update labels.
    func updateTimeLabels(valueHour: Int, valueMin: Int, valueSec: Int){
        
        hourLabel.text = String(valueHour)
        minLabel.text = String(valueMin)
        secLabel.text = String(valueSec)
        
    }
    
}
