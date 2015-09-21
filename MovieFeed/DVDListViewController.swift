
//
//  DVDListViewController.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit

class DVDListViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var DVDListCollectionView:UICollectionView!
    var DVDCollectionArray:[DVD] = [DVD]()
    var refreshControl:UIRefreshControl!
    var tumblrHud:AMTumblrHud = AMTumblrHud()
    var errorLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpView()
        self.setUpInitialValues()
        self.setUpDelegate()
    }
    
   
    func setUpCollectionViewFlowLayout(){
        let width:CGFloat = (CGRectGetWidth(view.frame))
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSizeMake(width,CGRectGetHeight(view.frame)/5)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        DVDListCollectionView.setCollectionViewLayout(flowLayout,animated:false)
        DVDListCollectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "DVD"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
    
    func setUpLoadingView(){
        tumblrHud = AMTumblrHud.init(frame: CGRectMake(100, 100, 55, 20))
        tumblrHud.hudColor = UIColor .grayColor()//UIColorFromRGB(0xF1F2F3)
        self.view.addSubview(tumblrHud)
        tumblrHud.showAnimated(true)
    }

    func addErrorView(){
        errorLabel = UILabel.init(frame:CGRectMake(0, 0, self.view.frame.size.width, 30))
        errorLabel.backgroundColor = UIColor.redColor()
        errorLabel.textColor = UIColor.grayColor()
        errorLabel.text = "Unable to load"
        DVDListCollectionView.insertSubview(errorLabel,atIndex:0)
    }

    
    func setUpView(){
        setUpCollectionViewFlowLayout()
        setUpNavigationBar()
        addRefreshControl()
    }
    
    func addRefreshControl(){
        refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action:"setUpInitialValues", forControlEvents:UIControlEvents.ValueChanged)
       DVDListCollectionView.insertSubview(refreshControl, atIndex: 0)
    }

    func setUpDelegate(){
        DVDListCollectionView.delegate = self;
        DVDListCollectionView.dataSource = self;
    }
    
    

    
    func setUpInitialValues(){
        //let clientId = "e2478f1f8c53474cb6a50ef0387f9756"
        let requestedURL = NSURL(string:"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(requestedURL, completionHandler: {data, response, error in
            // First, make sure we have real data, and handle the error if not.
            // (That's a better use of the API contract than checking the error parameter, because the error parameter is not guaranteed to be non-nil in all cases where correct data is received.)
            // Use a guard clause to keep the "good path" less indented.
            guard let actualData = data else {
                // self.responseText.text = "Response status: \(error!.description)"
                return
            }
            do {
                // Use do/try/catch to call the new throwing API.
                // Use the new OptionSetType syntax, too.
                let dataDictionary = try NSJSONSerialization.JSONObjectWithData(actualData, options: [])
                print(dataDictionary);
                dispatch_async(dispatch_get_main_queue(), {
                    let movies = dataDictionary["movies"] as! NSArray
                    for(var i=0;i<movies.count;i++){
                        let responseDictionary = movies[i] as! NSDictionary
                        let posters = responseDictionary["posters"] as! NSDictionary
                        let movieName = responseDictionary["title"] as! String
                        let movieRating = responseDictionary["mpaa_rating"] as! String
                        let movieTime = responseDictionary["runtime"] as! Int
                        let ratings = responseDictionary["ratings"] as!NSDictionary
                        let moviePercentage=ratings["audience_score"] as! Int
                        let movieImageURL = posters["original"] as! String
                        let casts = responseDictionary["abridged_cast"] as! NSArray
                        let summary = responseDictionary["synopsis"] as! String
                        var movieCasts:String = String()
                        for(var k=0;k<casts.count;k++){
                            let individualCast = casts[k] as! NSDictionary
                            let actor = individualCast["name"] as! String
                            movieCasts = movieCasts + actor + " "
                            
                        }
                        print("movieImageURL \(movieImageURL) , movieName \(movieName), movieRatings \(movieRating) movieTime \(movieTime) moviePercentage \(moviePercentage) movieCasts \(movieCasts) summary\(summary)")
                        
                        let currentMovie:DVD =
                        DVD.init(DVDImageURL: movieImageURL, DVDName: movieName, DVDRating: movieRating, DVDMinute: movieTime, DVDPercentage: moviePercentage, DVDCasts: movieCasts, DVDSummary: summary)
                        
                        self.DVDCollectionArray.append(currentMovie)
                    }
                    self.tumblrHud.showAnimated(false);
                    self.DVDListCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                })
            } catch let parseError {
                // No need to treat as NSError and call description here, because ErrorTypes are guaranteed to be describable.
                NSLog("Response status: \(parseError)")
            }
        })
        task.resume()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return DVDCollectionArray.count
    }
    
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath
        indexPath: NSIndexPath) -> UICollectionViewCell{
            let cell:DVDCollectionViewCell = DVDListCollectionView.dequeueReusableCellWithReuseIdentifier("DVDCollectionViewCell", forIndexPath: indexPath) as! DVDCollectionViewCell
            cell.setDVDCell(DVDCollectionArray[indexPath.row])
            return cell
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "DVDPushSegue"){
            let detailViewController:DVDDetailViewController = segue.destinationViewController as! DVDDetailViewController
            let cell = sender as! UICollectionViewCell
            let indexPath  = DVDListCollectionView!.indexPathForCell(cell) as NSIndexPath!
            let selectedDVDColleciton:DVD = DVDCollectionArray[indexPath.row]
            detailViewController.selectedCurrentMovie = selectedDVDColleciton
        }
    }
}


