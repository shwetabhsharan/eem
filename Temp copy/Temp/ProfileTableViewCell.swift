//
//  ProfileTableViewCell.swift
//  ElementsList
//
//  Created by Manish on 12/11/16.
//  Copyright © 2016 Forgeahead. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var ProfileLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
