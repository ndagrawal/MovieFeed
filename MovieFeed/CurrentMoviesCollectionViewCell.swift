//
//  CurrentMoviesTableViewCell.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit
import AFNetworking

class CurrentMoviesCollecitonViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage:UIImageView!
    @IBOutlet weak var movieName:UILabel!
    @IBOutlet weak var movieRating:UILabel!
    @IBOutlet weak var movieTime:UILabel!
    @IBOutlet weak var moviePercentage:UILabel!
    @IBOutlet weak var movieCasts:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCellUI(){
    self.layer.borderColor=UIColor.grayColor().CGColor
    self.layer.borderWidth=1.0
    
    }
    
    func setCurrentMovieCell(currentMovie:CurrentMovie){
        setUpCellUI()
        let url:NSURL = NSURL(string:currentMovie.movieImageURL)!
        movieImage.setImageWithURL(url)
        movieName.text = currentMovie.movieName
        movieRating.text = currentMovie.movieRating
        movieTime.text = String(currentMovie.movieTime)
        moviePercentage.text = String(currentMovie.moviePercentage)
        movieCasts.text = currentMovie.movieCasts
    }
}
