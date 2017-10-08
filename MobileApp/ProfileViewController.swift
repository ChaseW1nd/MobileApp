//
//  ProfileViewController.swift
//  MobileApp
//
//  Created by ellen on 5/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    // MARK: Properites
    
    var URL_USER_REGISTER = "http://10.13.2.137:8181/info"
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfo(){
        
        let parameters: [String: String] = [
            "type": "info",
            "sessionId": UserDefaults.standard.string(forKey: "sessionID")!
        ]
        
        // Sending http post request.
        Alamofire.request(URL_USER_REGISTER,
                          method: .post, parameters: parameters,
                          encoding: JSONEncoding.default
            ).responseJSON {
                response in
                switch response.result{
                case .success:
                    print("Request: \(String(describing: response.request))")   // original url request
                    print("Response: \(String(describing: response.response))") // http url response
                    print("Result: \(response.result)")                         // response serialization result
                    
                    // For testing
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                    }
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)") // original server data as UTF8 string
                    }
                    
                    let jsonData = response.result.value as! NSDictionary
                    self.usernameLabel.text = jsonData.value(forKey: "username") as! String?
                    self.nameLabel.text = jsonData.value(forKey: "name") as! String?
                    self.phoneLabel.text = jsonData.value(forKey: "phone") as! String?
                    
                case .failure(let error):
                    print(error)
                }
        }
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
