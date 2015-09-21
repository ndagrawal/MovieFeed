//
//  CurrentMovie.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class CurrentMovie: NSObject {

    var movieImageURL:String!
    var movieName:String!
    var movieRating:String!
    var movieTime:Int!
    var moviePercentage:Int!
    var movieCasts:String!
    var movieSummary:String!
    
    init(movieImageUrl:String ,movieName:String, movieRating:String ,movieTime:Int, moviePercentage:Int,movieCasts:String,movieSummary:String){
        self.movieImageURL = movieImageUrl
        self.movieName = movieName
        self.movieRating = movieRating
        self.movieTime = movieTime
        self.moviePercentage = moviePercentage
        self.movieCasts = movieCasts
        self.movieSummary = movieSummary
    }
    
    
    
}
