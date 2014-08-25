//
//  Album.swift
//  HelloWorld
//
//  Created by Carlos Fernandez on 25/08/14.
//  Copyright (c) 2014 Carlos Fernandez Artidiello. All rights reserved.
//

import Foundation

class Album{
    var title: String
    var price: String
    var thumbnailImageURL: String
    var largeImageURL: String
    var itemURL: String
    var artistURL: String
    
    init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String){
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
    }
    
    
}