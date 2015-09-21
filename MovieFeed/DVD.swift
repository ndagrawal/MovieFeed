
//
//  DVD.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class DVD: NSObject {
    
    var DVDName:String!
    var DVDRating:String!
    var DVDMinute:String!
    var DVDPercentage:String!
    var DVDImageURL:String!
    var DVDcasts:String!
    var DVDSummary:String!
    
    init(DVDImageURL:String ,DVDName:String, DVDRating:String ,DVDMinute:Int, DVDPercentage:Int,DVDCasts:String,DVDSummary:String){
        self.DVDImageURL = DVDImageURL
        self.DVDName = DVDName
        self.DVDRating = DVDRating
        self.DVDMinute = String(DVDMinute)
        self.DVDPercentage = String(DVDPercentage)
        self.DVDcasts = DVDCasts
        self.DVDSummary = DVDSummary
    }
}
