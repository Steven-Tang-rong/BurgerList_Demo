//
//  DemoTableViewCell.swift
//  BurgerList_Demo
//
//  Created by StevenTang on 2021/8/13.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

     let demoLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        demoLabel.frame.size = CGSize(width: 50, height: 50)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        demoLabel.frame.size = CGSize(width: 50, height: 50)

        // Configure the view for the selected state
    }

}
