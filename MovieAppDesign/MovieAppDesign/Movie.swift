//
//  Movie.swift
//  MovieAppDesign
//
//  Created by MacBook on 19.03.2022.
//

import Foundation

class Movie {
    
    var movie_name:String?
    var movie_id:String?
    var movie_image:String?
    var movie_year:Int?
    var movie_category:String?
    var producer_name:String?
    
    init() {
    }
    
    init(movie_name:String,movie_id:String,movie_image:String,movie_year:Int,movie_category:String,producer_name:String) {
        
        self.movie_name = movie_name
        self.movie_id = movie_id
        self.movie_image = movie_image
        self.movie_year = movie_year
        self.movie_category = movie_category
        self.producer_name = producer_name
    }
}
