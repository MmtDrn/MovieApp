//
//  MovieDetailsViewController.swift
//  MovieAppDesign
//
//  Created by MacBook on 8.03.2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelProducer: UILabel!
    
    var movie:Movie?
    var s:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let m = movie {
            
            navigationItem.title = m.movie_name
            
            labelMovieName.text = m.movie_name
            labelYear.text = "\(m.movie_year!)"
            labelCategory.text = m.movie_category
            labelProducer.text = m.producer_name
            
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(m.movie_image!).png") {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageMovie.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
}
