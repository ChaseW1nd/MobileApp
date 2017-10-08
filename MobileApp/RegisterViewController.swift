//
//  RegisterViewController.swift
//  MobileApp
//
//  Created by ellen on 4/10/17.
//  Copyright © 2017 ellen. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    // TODO: URL for server
    let URL_USER_REGISTER = "http://10.13.2.137:8181/register"
    
    // MARK: Properties
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
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
    @IBAction func signUpButton(_ sender: UIButton) {
        
//        let username = usernameField.text
//        let password = passwordField.text
//        let name = nameField.text
//        let phone = phoneField.text
        
        //if isValidPhone(value: phoneField.text!) {
        // FIXME: For testing
        if true {
            // Phone number is valid.
            debugPrint("All good", phoneField.text ?? "null")
            
            let parameters: [String: String] = [
                "type": "register",
                "username": usernameField.text!,
                "password": passwordField.text!,
                "name": nameField.text!,
                "phone": phoneField.text!
            ]
            
            // Sending http post request.
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
                    let test = jsonData.value(forKey: "state") as! String?
                    self.nameField.text = test
                
                case .failure(let error):
                    print(error)
                }
            }
            
            
//            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters
//                //, encoding: JSONEncoding.default
//                )
//                // FIXME: statusCode should align with the server implementation.
//                //.validate(statusCode: 200..<300)
//                .responseString {
//                    response in
//                    switch response.result {
//                    
//                    // TODO: Test connecting.
//                    case .success:
//                        // Print response.
//                        debugPrint(response)
//                    
//                        // Convert it as NSDictionary.
//                        //let jsonData = response.result.value as! NSDictionary
//                        
//                        //print(response.result.value(forKey: "test"))
//                        
//                        // Way to access: jsonData.value(forKey: "message") as! String?
//                        // jsonData.value(forKey: "sessionID") as! String?
//                        
//                    case .failure(let error):
//                        debugPrint(error)
//                }
//                    
//            }
            
            
        
        }else{
            
            // Phone number is invalid.
            phoneField.text = ""
            phoneField.becomeFirstResponder()
            let alert = UIAlertController(title: "Oops",
                                          message: "Invalid phone number!",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Re-enter",
                                       style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
        }
        
    }
    
    // Validate phone number.
    func isValidPhone(value: String) -> Bool {
        
        if value.characters.count != 10 {
            print(value)
            return false
            
        }else{
            let PHONE_REGEX = "^0\\d{9}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            return phoneTest.evaluate(with: value)
        }
        
        
        
    }
    
    
    
    
}
