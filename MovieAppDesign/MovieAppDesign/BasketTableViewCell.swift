//
//  BasketTableViewCell.swift
//  MovieAppDesign
//
//  Created by MacBook on 19.03.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
