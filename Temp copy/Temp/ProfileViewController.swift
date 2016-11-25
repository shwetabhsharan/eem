//
//  ProfileViewController.swift
//  ElementsList
//
//  Created by Manish on 12/11/16.
//  Copyright © 2016 Forgeahead. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var FullName: UILabel!
    @IBOutlet weak var Designation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var EmployeeDetails: UILabel!
   
    var employee_id : NSNumber! = -1
    var profileTableIcon = NSMutableArray.init()
    var profileTableValues = NSMutableArray.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        get_employee_information(emp_id: employee_id)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProfileTableViewCell
        customCell.ProfileLable?.text = profileTableValues.object(at: indexPath.row) as! String
        customCell.ProfileImageView?.image = UIImage(named: profileTableIcon.object(at: indexPath.row) as! String)
        return customCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileTableValues.count
    }
    
    func get_employee_information(emp_id: NSNumber){
        let emp_id = employee_id!.intValue as Int
        let session = URLSession.shared
        let url : String = "http://idisruptors.forgeahead.io/employees/\(emp_id).json"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let defaults = UserDefaults.standard
        request.addValue(defaults.string(forKey: "email")!, forHTTPHeaderField: "user-email")
        request.addValue(defaults.string(forKey: "authentication_token")!, forHTTPHeaderField: "user-token")
        session.dataTask(with: request) {data, response, err in
            
            let response_string = String(data: data!, encoding: .utf8)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do{
                        let decoded_json : NSDictionary = try JSONSerialization.jsonObject(with: (response_string?.data(using: String.Encoding.utf8)!)!, options: JSONSerialization.ReadingOptions.mutableContainers) as!  NSDictionary
                        DispatchQueue.main.async {
                            let first_name = decoded_json["first_name"] as! String
                            let last_name = decoded_json["last_name"] as! String
                            self.FullName.text = first_name + " " + last_name
                            let url = decoded_json["photo"] as! String
                            let base_url = "http://idisruptors.forgeahead.io\(url)"
                            let full_url = URL(string:base_url)
                            let data = try? Data(contentsOf: full_url!)
                            self.ProfilePic.image = UIImage(data: data!)
                            self.ProfilePic.layer.cornerRadius = self.ProfilePic.frame.size.width / 2;
                            self.ProfilePic.clipsToBounds = true;
                            self.Designation.text = decoded_json["job_title"] as! String
                            self.EmployeeDetails.text = decoded_json["employee_code"] as! String
                            self.profileTableValues.add(decoded_json["employee_code"] as! String)
                            self.profileTableValues.add(decoded_json["date_of_birth"] as! String)
                            self.profileTableValues.add(decoded_json["joining_date"] as! String)
                            if (decoded_json["login_email"] != nil){
                            self.profileTableValues.add(decoded_json["login_email"] as! String)
                            }
                            self.profileTableValues.add(decoded_json["mobile"] as! String)
                            self.profileTableValues.add(decoded_json["gender"] as! String)
                            self.profileTableIcon.add("employee_code")
                            self.profileTableIcon.add("dob")
                            self.profileTableIcon.add("joining_date")
                            self.profileTableIcon.add("email")
                            self.profileTableIcon.add("mobile_icon")
                            self.profileTableIcon.add("skills")
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }catch{
                    }
                } else if httpResponse.statusCode == 500 {
                    print("internal server error", err)
                }
            }
        }.resume()
    }
    
}
