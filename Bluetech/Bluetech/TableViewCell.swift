//
//  TableViewCell.swift
//  Bluetech
//
//  Created by Eugenie Tyan on 4/7/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {


    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    func setCell(name: String, phone: String, tags: String) {
        nameLabel.text = name
        phoneLabel.text = phone
        tagsLabel.text = tags
    }
    
    func setCellWithImage(image: UIImage, name: String, phone: String, tags: String) {
        phoneImage.image = image
        nameLabel.text = name
        phoneLabel.text = phone
        tagsLabel.text = tags
    }
        
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
