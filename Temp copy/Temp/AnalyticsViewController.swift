//
//  TableViewController.swift
//  ApiCallForEmp
//
//  Created by Sunil Lohar on 11/11/16.
//  Copyright © 2016 SNS Technologies. All rights reserved.
//

import UIKit

class AnalyticsViewController: UITableViewController {
    var number = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Analytics"
        
        
        let button1 = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: Selector("action"))
        self.navigationItem.rightBarButtonItem  = button1
        
        
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0){
        return 250
        }
        else{
        return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "1323")
        
        
        if(indexPath.row==0)
        {
            cell.backgroundView = UIImageView(image: UIImage(named: "measure"))
        }
        else if(indexPath.row == 1)
        {
            cell.backgroundView = UIImageView(image: UIImage(named: "ecengage"))
        }
        else if(indexPath.row == 2)
        {
            cell.backgroundView = UIImageView(image: UIImage(named: "edengage"))
        }
            
        else if(indexPath.row == 3)
        {
            cell.backgroundView = UIImageView(image: UIImage(named: "eeengage"))
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if (indexPath[1] == 1)
        {
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "e2c") as? E2CController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            //self.performSegue(withIdentifier: "e2c", sender: self)
            
            
        }
        else if (indexPath[1] == 2)
        {
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "e2d") as? E2DController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            
        }
        
        else if(indexPath.row == 3){
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "e2e") as? E2EController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
