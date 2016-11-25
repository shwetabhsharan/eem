//
//  ViewController.swift
//  Temp
//
//  Created by admin on 11/10/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let headers: HTTPHeaders = [
            "user-token": "ssGozEuKJkxzxLEQK1o7",
            "user-email" : "lareb.nawab@forgeahead.io",
            "Content-Type": "application/json"
            
        ]
        
     /*   let parameters: [String: Any] = [
            "user": [
                    "email" : "lareb.nawab@forgeahead.io",
                    "password" : "password"
                ]
        ]
     
        
        Alamofire.request("http://idisruptors.forgeahead.io/users/sign_in.json",method: .post, parameters: parameters).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginOperation(_ sender: AnyObject) {
        
        let parameters: [String: Any] = [
            "user": [
                "email" : txtUserName.text!,
                "password" : txtUserPassword.text!
            ]
        ]
        
        
        Alamofire.request("http://idisruptors.forgeahead.io/users/sign_in.json",method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response?.statusCode
            print("statusCode: \(statusCode)")
            switch response.result {
            case .success:
                // after success
                if statusCode == 200 {
                    //get email and token
                   let user = response.result.value as! NSDictionary
                    print(user["email"])
                    print(user["authentication_token"])
                    //Save email and token
                    let defaults = UserDefaults.standard
                    defaults.set(user["email"], forKey: "email")
                    defaults.set(user["authentication_token"], forKey: "authentication_token")
                    print(defaults.string(forKey: "email"))
                    
                    self.txtUserName.text = ""
                    self.txtUserPassword.text = ""
                    // Go to next screen
                    //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "UIHomeScreenController") as! UIHomeScreenController
                    //let nextViewController = self.storyBoard.instantiateViewController(withIdentifier: "UIHomeScreenController") as! UIHomeScreenController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
//                    self.navigationController?.present(nextViewController, animated: true, completion: nil)
                    
                }else{
                    //Show Error alert
                    let alert = UIAlertController(title: "Authentication Failure", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .failure(let error):
                print(error)
            }
         
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.txtUserName.resignFirstResponder()
        self.txtUserPassword.resignFirstResponder()
    }
}

