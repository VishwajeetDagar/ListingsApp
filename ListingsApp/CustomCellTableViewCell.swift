//
//  CustomCellTableViewCell.swift
//  ListingsApp
//
//  Created by Vishwajeet Dagar on 1/25/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var unitTypeText: UILabel!
    @IBOutlet weak var imagecell: UIImageView!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
