//
//  CategoryTableViewCell.swift
//  MovieAppDesign
//
//  Created by MacBook on 8.03.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCategoryName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
