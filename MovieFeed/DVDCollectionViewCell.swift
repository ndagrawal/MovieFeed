

//
//  DVDCollectionViewCell.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class DVDCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DVDImage:UIImageView!
    @IBOutlet weak var DVDName:UILabel!
    @IBOutlet weak var DVDTime:UILabel!
    @IBOutlet weak var DVDRating:UILabel!
    @IBOutlet weak var DVDPercentage:UILabel!
    @IBOutlet weak var DVDCasts:UILabel!
    
    func setUpCellUI(){
        self.layer.borderColor=UIColor.grayColor().CGColor
        self.layer.borderWidth=1.0
    }
    func setDVDCell(dvd:DVD){
        setUpCellUI()
        let url:NSURL = NSURL(string:dvd.DVDImageURL)!
        DVDImage.setImageWithURL(url)
        DVDName.text = dvd.DVDName
        DVDTime.text = dvd.DVDMinute
        DVDRating.text = dvd.DVDRating
        DVDPercentage.text = dvd.DVDPercentage
        DVDCasts.text = dvd.DVDcasts
    }
    
    
    
    
}
