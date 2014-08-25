//
//  ViewController.swift
//  HelloWorld
//
//  Copyright (c) 2014 Jameson Quave. All rights reserved.
//  http://jamesonquave.com
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.apiController.delegate = self
        apiController.searchItunesFor("Angry Birds")
    }
    
    @IBOutlet var myAppTableView: UITableView?
    var tableData = []
    var apiController = APIController()
    let kCellIdentifier: String = "SearchResultCell"
    
    var imageCache = [String: UIImage]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
//        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        let cellText: String? = rowData["trackName"] as? String
        cell.textLabel.text = cellText
        cell.imageView.image = UIImage(named: "Blank52")
        
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice

        
//        cell.textLabel.text = rowData["trackName"] as String
        
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        
        var image = self.imageCache[urlString]
        
        if (image == nil){
            var imgUrl: NSURL = NSURL(string: urlString)
            
            let request: NSURLRequest = NSURLRequest(URL: imgUrl)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if error == nil{
                    image = UIImage(data: data)
                    self.imageCache[urlString] = image
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
                        cellToUpdate.imageView.image = image
                    }
                }
                else{
                    println("Error: \(error.localizedDescription)")
                }
            })
        }
        else{
            dispatch_async(dispatch_get_main_queue(),{
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
                    cellToUpdate.imageView.image = image
                }
            })
        }
        
        
//        let imgUrl: NSURL = NSURL(string: urlString)
//        
//        let imgData: NSData = NSData(contentsOfURL: imgUrl)
//        cell.imageView.image = UIImage(data: imgData)
//        
        
        return cell
        
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArray: NSArray = results["results"] as NSArray
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArray
            self.myAppTableView!.reloadData()
        })
        
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        var name: String = rowData["trackName"] as String
        var price: String = rowData["formattedPrice"] as String
        
        var alert: UIAlertView = UIAlertView()
        alert.title = name
        alert.message = price
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    
}

