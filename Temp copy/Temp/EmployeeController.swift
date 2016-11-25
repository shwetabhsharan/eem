//
//  ViewController.swift
//  ElementsList
//
//  Created by Shwetabh Sharan on 11/11/16.
//  Copyright © 2016 Forgeahead. All rights reserved.
//

import UIKit

class EmployeeController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "index\(indexPath.row)")
        cell.textLabel?.text = employee_data.object(at: indexPath.row) as! String
        let full_url = URL(string:employee_url.object(at: indexPath.row) as! String)
        let data = try? Data(contentsOf: full_url!)
        if(data != nil){
            cell.imageView?.image = UIImage(data: data!)
            cell.imageView?.layer.cornerRadius = 40;
            cell.imageView?.clipsToBounds = true;
        }
        
        return cell    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee_data.count
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationItem.title = "Employees"
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
       // self.navigationItem.setHidesBackButton(true, animated:true);
        //self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    
    var employee_data = NSMutableArray.init()
    var employee_url = NSMutableArray.init()
    var user_id_map = [NSNumber : AnyObject]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.navigationBar.topItem?.title = "Employee"
        self.get_employees()
        tableView.dataSource = self
        tableView.delegate = self
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        var target_index = indexPath.row
        var employee_id = self.user_id_map[target_index as NSNumber]
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        mapViewControllerObj?.employee_id = employee_id as! NSNumber?
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    func get_employees(){
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "http://idisruptors.forgeahead.io/employees.json")!)
        request.httpMethod = "GET"
        let defaults = UserDefaults.standard
        request.addValue(defaults.string(forKey: "email")!, forHTTPHeaderField: "user-email")
        request.addValue(defaults.string(forKey: "authentication_token")!, forHTTPHeaderField: "user-token")
        session.dataTask(with: request) {data, response, err in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            let response_string = String(data: data!, encoding: .utf8)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do{
                        let decoded_json : NSDictionary = try JSONSerialization.jsonObject(with: (response_string?.data(using: String.Encoding.utf8)!)!, options: JSONSerialization.ReadingOptions.mutableContainers) as!  NSDictionary
                        let arr = decoded_json.object(forKey: "employees") as! NSArray
                        for (index, value) in arr.enumerated() {
                            let dict_value = value as? NSDictionary
                            self.user_id_map[index as NSNumber] = dict_value?["id"] as? NSNumber
                            let first_name = dict_value?["first_name"] as? String
                            let last_name = dict_value?["last_name"] as? String
                            var clean_first_name = ""
                            var clean_last_name = ""
                            if (first_name != nil){
                                clean_first_name = first_name! as String
                            }
                            if (last_name != nil){
                                clean_last_name = last_name! as String
                            }
                            
                            let full_name = "\(clean_first_name) \(clean_last_name)"
                            self.employee_data.add(full_name)
                            let url = dict_value?["photo"] as! String
                            let base_url = "http://idisruptors.forgeahead.io\(url)"
                            self.employee_url.add(base_url)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                        //print(self.user_id_map)
                }catch{
                    }
                } else if httpResponse.statusCode == 500 {
                    print("internal server error", err)
                }
            }
        }.resume()
    }

}



 
