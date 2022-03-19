//
//  MoviesCollectionViewCell.swift
//  MovieAppDesign
//
//  Created by MacBook on 8.03.2022.
//

import UIKit

protocol CollectionProtocol {
    
    func addToBasket(indexPath:IndexPath)
}

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var cellProtocol:CollectionProtocol?
    var indexPath:IndexPath?
    
    @IBAction func addToBasketButton(_ sender: Any) {
        cellProtocol?.addToBasket(indexPath: indexPath!)
    }
    
}
