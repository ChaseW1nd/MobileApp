//
//  ReceiverViewController.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
import GooglePlaces

class ReceiverViewController: UIViewController, GMSMapViewDelegate ,  CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var googlemaps: UIView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        drawpoint()

        LoadMap(lat: -37.7991, lon: 144.9631, zoom: 15.0)
 
    }
    
    // MARK: Methods
    
    func drawpoint()
    {
        
        let url = "http://10.13.2.137:8181/location"

        
        let parameters: [String: Any] = [
            "positionX": "xx",
            "positionY": "yy",
            "sessionId": "1234",
            "method" : "send",
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
    
    func LoadMap(lat: Double, lon:Double,zoom: Float){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        mapView.settings.rotateGestures = true
        mapView.settings.setAllGesturesEnabled(true)
        mapView.settings.zoomGestures = true
        mapView.settings.tiltGestures = true
        
        marker.map = mapView
        
    }

}
