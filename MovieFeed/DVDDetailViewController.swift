
//
//  DVDDetailViewController.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class DVDDetailViewController: UIViewController{

    var selectedCurrentMovie:DVD?

    @IBOutlet weak var selectedMovieSummary: UITextView!
    @IBOutlet weak var selectedMovieImage:UIImageView!
//    @IBOutlet weak var selectedMovieCasts: UILabel!
    @IBOutlet weak var selectedMovieName: UILabel!
//    @IBOutlet weak var selectedMoviePercentage: UILabel!
//    @IBOutlet weak var selectedMovieMinutes: UILabel!
//    @IBOutlet weak var selectedMovieRating: UILabel!
//    
    //TODO : Set the detail image and detail text in the view did load method
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedMovieName.text = selectedCurrentMovie?.DVDName!
        
//        selectedMovieCasts.text = "Casts: \n"+(selectedCurrentMovie?.DVDcasts!)!
        
        let url:NSURL = NSURL(string: (selectedCurrentMovie?.DVDImageURL)!)!
        selectedMovieImage.setImageWithURL(url)
//        selectedMoviePercentage.text = String(selectedCurrentMovie?.DVDPercentage)
//        selectedMovieMinutes.text = String(selectedCurrentMovie?.DVDMinute)
//        selectedMovieRating.text = selectedCurrentMovie?.DVDRating!
      selectedMovieSummary.text = selectedCurrentMovie?.DVDSummary!
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
