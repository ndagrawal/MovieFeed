
//
//  CurrentMoviesDetailViewController.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class CurrentMoviesDetailViewController: UIViewController {
    var selectedCurrentMovie:CurrentMovie?
    @IBOutlet weak var selectedMovieSummary: UITextView!
    
    @IBOutlet weak var selectedMovieImage:UIImageView!
//    @IBOutlet weak var selectedMovieCasts: UILabel!
    @IBOutlet weak var selectedMovieName: UILabel!
//    @IBOutlet weak var selectedMoviePercentage: UILabel!
//    @IBOutlet weak var selectedMovieMinutes: UILabel!
//    @IBOutlet weak var selectedMovieRating: UILabel!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedMovieName.text = selectedCurrentMovie?.movieName!
       // selectedMovieCasts.text = "Casts:\n"+(selectedCurrentMovie?.movieCasts)!
        let url:NSURL = NSURL(string: (selectedCurrentMovie?.movieImageURL)!)!
        selectedMovieImage.setImageWithURL(url)
       // selectedMoviePercentage.text = String(selectedCurrentMovie?.moviePercentage)
       // selectedMovieMinutes.text = String(selectedCurrentMovie?.movieTime)
       // selectedMovieRating.text = selectedCurrentMovie?.movieRating!
        selectedMovieSummary.text = selectedCurrentMovie?.movieSummary!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
