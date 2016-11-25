//
//  TeamGoal.swift
//  ApiCallForEmp
//
//  Created by Sunil Lohar on 11/11/16.
//  Copyright © 2016 SNS Technologies. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TeamGoal: UIViewController{
    
    @IBOutlet weak var teamGoalView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        let defaults = UserDefaults.standard
        
        let headers: HTTPHeaders = [
            "user-email": defaults.string(forKey: "email")!,
            "user-token": defaults.string(forKey: "authentication_token")!,
            "Content-type": "application/json"
        ]
        Alamofire.request("http://idisruptors.forgeahead.io/teams/2/goals/7.json", headers: headers).responseJSON { response in
            
            if let JSON = response.result.value {
                var detail = JSON as! NSDictionary
                self.teamGoalView.text! = detail["description"] as! String
                
            }
        }

    }
}
