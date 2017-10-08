
//  MapController.swift
//  MobileApp
//
//  Created by Leon Wei on 1/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapController : UIViewController,UISearchBarDelegate,  LocateOnTheMap,GMSAutocompleteFetcherDelegate,GMSMapViewDelegate ,  CLLocationManagerDelegate
   
{
    // MARK: Properites
    var current = ""
    var target = ""
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    @IBOutlet weak var googleMapsContainer: UIView!

    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        self.googleMapsView = GMSMapView(frame: self.googleMapsContainer.frame)
        
        self.googleMapsView?.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        self.googleMapsView.settings.compassButton = true
        self.googleMapsView.settings.zoomGestures = true
        self.googleMapsView.settings.compassButton = true
        self.googleMapsView.isMyLocationEnabled = true
        
//        if let current = self.googleMapsView.myLocation {
//            print("User's location: \(current)")
//        } else {
//            print("User's location is unknown")
//        }
        
        self.view.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
        
    }
    

    @IBAction func searchWithAddress(_ sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController
        )
        
        searchController.searchBar.delegate = self
        self.present(searchController, animated:true, completion: nil)
    }
    
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
    
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 17.0)
            self.googleMapsView.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
            
            self.target = title
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "returnLocation" {
            let nextController = segue.destination as! MainViewController
            nextController.currentLocation = current
            nextController.targetLocation = target
            
            nextController.selectedIndex = 0
            
        }
        
    }
}
