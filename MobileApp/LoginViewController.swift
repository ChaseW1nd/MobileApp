//
//  LoginViewController.swift
//  MobileApp
//
//  Created by ellen on 4/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//
//  The icon of this app is found from
//  <a href="https://icons8.com/icon/53130/Crosswalk">Crosswalk icon credits</a>

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    let URL_USER_REGISTER = "http://10.13.2.137:8181/login"
    var authentication = false;
    
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
    
    
    // MARK: Actions
    
    
    // TODO: Login authentication.
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        if checkValid() {
            
            let parameters: [String: String] = [
                "type": "register",
                "username": usernameField.text!,
                "password": passwordField.text!
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
                    
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                    }
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)") // original server data as UTF8 string
                    }
                    
                    let jsonData = response.result.value as! NSDictionary
                    let message = jsonData.value(forKey: "state") as! String?
                    
                    let alert = UIAlertController(title: "Result",
                                                  message: message,
                                                  preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK",
                                               style: .default, handler: nil)
                    alert.addAction(action)
                    self.authentication = true
                    print(self.authentication)
                    
                    let session = jsonData.value(forKey: "sessionId") as! String?
                    UserDefaults.standard.set(session, forKey: "sessionID")
                    
                case .failure(let error):
                    print(error)
                }
            }
            
            
            
        }else{
            
            messageField.text = "Empty username or password"
            print("enter false")
            
        }
        
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "authentication" {
            return authentication
        }
        return true
    }
    
    func checkValid() -> Bool{
        if (usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!{
            
            return false
        }else{
            return true
        }
    }

}
