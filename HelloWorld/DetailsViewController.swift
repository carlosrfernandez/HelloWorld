//
//  DetailsViewController.swift
//  HelloWorld
//
//  Created by Carlos Fernandez Artidiello on 26/08/14.
//  Copyright (c) 2014 Carlos Fernandez Artidiello. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    var album: Album?
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
}
