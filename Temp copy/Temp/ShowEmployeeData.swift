//
//  ShowEmployeeData.swift
//  ElementsList
//
//  Created by Shwetabh Sharan on 11/11/16.
//  Copyright © 2016 Forgeahead. All rights reserved.
//

import Foundation
import UIKit

class ShowEmployeeData: UIViewController{
    @IBOutlet weak var first_name: UILabel!
    @IBOutlet weak var last_name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var employee_code: UILabel!
    @IBOutlet weak var date_of_birth: UILabel!
    @IBOutlet weak var joining_date: UILabel!
    @IBOutlet weak var job_title: UILabel!
    @IBOutlet weak var login_email: UILabel!
    @IBOutlet weak var mobile: UILabel!

    
    
    var employee_id : NSNumber! = -1
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        get_employee_information(emp_id: employee_id)
        
    }

    func get_employee_information(emp_id: NSNumber){
        var emp_id = employee_id!.intValue as Int
        let session = URLSession.shared
        var url : String = "http://idisruptors.forgeahead.io/employees/\(emp_id).json"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let defaults = UserDefaults.standard
        request.addValue(defaults.string(forKey: "email")!, forHTTPHeaderField: "user-email")
        request.addValue(defaults.string(forKey: "authentication_token")!, forHTTPHeaderField: "user-token")
        session.dataTask(with: request) {data, response, err in
            DispatchQueue.main.async {
//                self.tableView.reloadData()
            }
            let response_string = String(data: data!, encoding: .utf8)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do{
                        let decoded_json : NSDictionary = try JSONSerialization.jsonObject(with: (response_string?.data(using: String.Encoding.utf8)!)!, options: JSONSerialization.ReadingOptions.mutableContainers) as!  NSDictionary
                        DispatchQueue.main.async {
                            self.first_name.text! = decoded_json["first_name"] as! String
                            self.last_name.text! = decoded_json["last_name"] as! String

                            var url = decoded_json["photo"] as! String
                            var base_url = "http://idisruptors.forgeahead.io\(url)"
                            let full_url = URL(string:base_url)
                            let data = try? Data(contentsOf: full_url!)
                            self.photo.image = UIImage(data: data!)
                            self.photo.layer.cornerRadius = self.photo.frame.size.width / 2;
                            self.photo.clipsToBounds = true;
                            self.employee_code.text! = decoded_json["employee_code"] as! String
                            self.date_of_birth.text! = decoded_json["date_of_birth"] as! String
                            self.joining_date.text = decoded_json["joining_date"] as! String
                        
                            self.job_title.text = decoded_json["job_title"] as? String
                            self.mobile.text = decoded_json["mobile"] as! String

                        }

                        
                    }catch{
                    }
                } else if httpResponse.statusCode == 500 {
                    print("internal server error", err)
                }
            }
            }.resume()    }
}

