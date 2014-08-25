//
//  APIController.swift
//  HelloWorld
//
//  Created by Carlos Fernandez Artidiello on 18/08/14.
//  Copyright (c) 2014 Carlos Fernandez Artidiello. All rights reserved.
//

import Foundation

protocol APIControllerProtocol{
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController{
    
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol){
        
        self.delegate = delegate
        
    }

    func searchItunesFor(searchTerm: String){
        
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
        
        let url: NSURL = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url, completionHandler: {
            data, response, error -> Void in
            println("Task completed")
            
            if(error)
            {
                println(error.localizedDescription)
                
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if(err != nil){
                
                println("Json error \(err!.localizedDescription)")
            }
            
            let results: NSArray = jsonResult["results"] as NSArray
            
            self.delegate.didReceiveAPIResults(jsonResult)
            
        })
        
        task.resume()
    }
}
