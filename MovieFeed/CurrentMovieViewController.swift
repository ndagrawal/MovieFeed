//
//  CurrentMovieViewController.swift
//  MovieFeed
//
//  Created by Nilesh Agrawal on 9/17/15.
//  Copyright © 2015 Nilesh Agrawal. All rights reserved.
//

import UIKit


class CurrentMovieViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var currentMoviesCollectionView:UICollectionView!
    var currentMoviesArray:[CurrentMovie]=[CurrentMovie]()
    var refreshControl:UIRefreshControl!
    var tumblrHud:AMTumblrHud = AMTumblrHud()
    var errorLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        currentMoviesCollectionView.setCollectionViewLayout(flowLayout,animated:false)
        currentMoviesCollectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        self.tabBarController?.tabBar.barTintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:0.8)
        self.tabBarController?.view.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
    
    func setUpLoadingView(){
        tumblrHud = AMTumblrHud.init(frame: CGRectMake(100, 100, 55, 20))
        tumblrHud.hudColor = UIColor .grayColor()//UIColorFromRGB(0xF1F2F3)
        self.view.addSubview(tumblrHud)
        tumblrHud.showAnimated(true)
    }
    func setUpView(){
       // self.view.backgroundColor = UIColor.greenColor()
        setUpCollectionViewFlowLayout()
        setUpNavigationBar()
        addRefreshControl()

    }
    
    func addErrorView(){
        errorLabel = UILabel.init(frame:CGRectMake(0, 0, self.view.frame.size.width, 30))
        errorLabel.backgroundColor = UIColor.redColor()
        errorLabel.textColor = UIColor.grayColor()
        errorLabel.text = "Unable to load"
        currentMoviesCollectionView.insertSubview(errorLabel,atIndex:0)
    }
    func addRefreshControl(){
        refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action:"setUpInitialValues", forControlEvents:UIControlEvents.ValueChanged)
        currentMoviesCollectionView.insertSubview(refreshControl, atIndex: 0)
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
                    
                        let currentMovie:CurrentMovie = CurrentMovie.init(movieImageUrl: movieImageURL, movieName: movieName, movieRating: movieRating, movieTime: movieTime, moviePercentage: moviePercentage,movieCasts:movieCasts,movieSummary:summary)
                        self.currentMoviesArray.append(currentMovie)
                        
                    }
                    self.tumblrHud.showAnimated(false)
                    self.currentMoviesCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                })
            } catch let parseError {
                // No need to treat as NSError and call description here, because ErrorTypes are guaranteed to be describable.
                NSLog("Response status: \(parseError)")
            }
        })
        task.resume()
    }

    
    func setUpDelegate(){
        currentMoviesCollectionView.delegate = self;
        currentMoviesCollectionView.dataSource = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return currentMoviesArray.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = currentMoviesCollectionView.dequeueReusableCellWithReuseIdentifier("CurrentMovieCollectionViewCell", forIndexPath: indexPath) as!CurrentMoviesCollecitonViewCell
        cell.setCurrentMovieCell(currentMoviesArray[indexPath.row])
        return cell;
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "currentMovieSegue"){
            let currentMovieDetailViewController:CurrentMoviesDetailViewController = segue.destinationViewController as! CurrentMoviesDetailViewController
            let cell = sender as! UICollectionViewCell
            let indexPath:NSIndexPath = currentMoviesCollectionView.indexPathForCell(cell) as NSIndexPath!
            let selectedCurrentMovie:CurrentMovie = currentMoviesArray[indexPath.row] 
            currentMovieDetailViewController.selectedCurrentMovie = selectedCurrentMovie
        }
    }
    

}
