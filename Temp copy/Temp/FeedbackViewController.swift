//
//  FeedbackViewController.swift
//  hackthon
//
//  Created by Rohit Mahto on 12/11/16.
//  Copyright © 2016 Rohit Mahto. All rights reserved.
//

import UIKit
 import ActionSheetPicker_3_0

class FeedbackViewController: UIViewController {

    var dept : NSMutableArray?
    var deptId : NSMutableArray?
    var catagory : NSMutableArray?
    var selectedDep : String?
    var selectedDepId : Int?
    @IBOutlet weak var messageTextbox: UITextView!
    
    @IBOutlet weak var selectMessage: UIButton!
    @IBOutlet weak var selectDepButton: UIButton!
    var selectedMessage : String?
     var selectedMessageId : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dept = NSMutableArray.init()
        deptId = NSMutableArray.init()
        catagory = NSMutableArray.init()
   
        
        
        catagory?.add("Suggestion")
        catagory?.add("Complaint")
        catagory?.add("Improvement")
        catagory?.add("Idea")
        
        
        
        
        let defaults = UserDefaults.standard
        var request = URLRequest(url: URL(string: "http://idisruptors.forgeahead.io/companies/1/business_units/1/departments.json")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(defaults.string(forKey: "email")!, forHTTPHeaderField: "user-email")
        request.setValue(defaults.string(forKey: "authentication_token")!, forHTTPHeaderField: "user-token")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let decodedJson : NSDictionary = try JSONSerialization.jsonObject(with: (responseString?.data(using: String.Encoding.utf8)!)!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let tmp : NSArray = decodedJson.object(forKey: "departments") as! NSArray
                for val in tmp{
                    let dep = val as! NSDictionary
                    let name = (dep.object(forKey: "head") as! NSDictionary)["first_name"]
                    let id = (dep.object(forKey: "head") as! NSDictionary)["id"] as! Int
                    let dep_name = dep["title"]!
                    let dep_string =  "\(dep_name) - \(name!)"
                    self.dept?.add(dep_string)
                    self.deptId?.add(id)
                    
                }
                DispatchQueue.main.async {
                    
                    
                }
                
                
            }catch{
                
            }
            
            
        }
        task.resume()
        
        

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func selectDepart(_ sender: AnyObject) {
        
        ActionSheetMultipleStringPicker.show(withTitle: "Select Catagory ", rows: [
            dept!,
            ], initialSelection: [0,] , doneBlock: {
                picker, values, indexes in
                let val = values as! NSArray
                self.selectedDep =  self.dept?.object(at: val.object(at: 0) as! Int) as! String?
                self.selectedDepId = self.deptId?.object(at: val.object(at: 0) as! Int) as! Int?
//                self.selectDepButton.title  = self.selectedDep!
                self.selectDepButton.setTitle(self.selectedDep!, for: UIControlState.normal)
                
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        
        
    }
    
    
    @IBAction func selectCatagori(_ sender: AnyObject) {
        
        ActionSheetMultipleStringPicker.show(withTitle: "Select Catgory ", rows: [
            self.catagory!,
            ], initialSelection: [0,] , doneBlock: {
                picker, values, indexes in
                
                let v = values as! NSArray
                let vv = indexes as! NSArray
//                self.selectedMessage =  v.object(at: 0) as! String
                
                self.selectedMessageId = v.object(at: 0) as! Int

                
                self.selectMessage.setTitle(vv.object(at: 0) as! String, for: UIControlState.normal)
                return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendMessage(_ sender: AnyObject) {
        
        
        if(self.selectedDepId  == nil && self.selectedMessage == nil){
            let alert = UIAlertView.init(title: "Warning", message: "Please select department and message catagory frist", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
            
        }
        
        var request = URLRequest(url: URL(string: "http://idisruptors.forgeahead.io/messages.json")!)
        request.httpMethod = "POST"
        let val = NSMutableDictionary.init()
        val.setValue(self.messageTextbox.text!, forKey: "body")
        val.setValue(false, forKey: "anonymous")
        val.setValue(self.selectedMessageId!, forKey: "message_category_id")
        val.setValue(self.selectedDepId!, forKey: "recipient_id")
        
        let mes = NSMutableDictionary.init()
        mes.setValue(val, forKey: "message")
        do{
            let data = try JSONSerialization.data(withJSONObject: mes, options: JSONSerialization.WritingOptions.prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            request.httpBody = json?.data(using: String.Encoding.utf8.rawValue)
        }
        catch{
            
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("lareb.nawab@forgeahead.io", forHTTPHeaderField: "user-email")
        request.setValue("ssGozEuKJkxzxLEQK1o7", forHTTPHeaderField: "user-token")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async {
                    
                let alert = UIAlertView.init(title: "Message", message: "Message sent failed, Please try again", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                }
            }
            
            DispatchQueue.main.async {
                
            let alert = UIAlertView.init(title: "Message", message: "Message sent sucessfully", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
                self.messageTextbox.text = ""
            }
            
    
        }
        task.resume()
        
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.messageTextbox.resignFirstResponder()
    }
}
