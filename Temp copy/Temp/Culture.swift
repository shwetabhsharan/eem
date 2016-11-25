//
//  Culture.swift
//  ApiCallForEmp
//
//  Created by Sunil Lohar on 11/11/16.
//  Copyright © 2016 SNS Technologies. All rights reserved.
//

import Foundation

import UIKit
import Alamofire

class Culture: UIViewController{
    
    
    @IBOutlet weak var cultureView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        let defaults = UserDefaults.standard
        
        let headers: HTTPHeaders = [
            "user-email": defaults.string(forKey: "email")!,
            "user-token": defaults.string(forKey: "authentication_token")!,
            "Content-type": "application/json"
        ]
        
        Alamofire.request("http://idisruptors.forgeahead.io/companies/1/dimensions.json", headers: headers).responseJSON { response in
             if let JSON = response.result.value {
                var detail = JSON as! NSDictionary
                var dimension  =  detail["dimensions"] as! NSArray
                var culture = dimension[0] as! NSDictionary
                 DispatchQueue.main.async {
                self.cultureView.text! = culture["description"] as! String
                }
                
            }
        }

    }
}
