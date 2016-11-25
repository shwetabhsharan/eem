//
//  UIHomeScreenController.swift
//  Temp
//
//  Created by admin on 11/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class UIHomeScreenController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var firstViewController:UIViewController = UIViewController()
        // The following statement is what you need
        let customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "YOUR_IMAGE_NAME")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "YOUR_IMAGE_NAME"))
        firstViewController.tabBarItem = customTabBarItem
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

}
