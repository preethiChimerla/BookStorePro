//
//  Book.swift
//  BookStorePro
//
//  Created by preethi Reddy on 2/28/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import Foundation

class Book {
    private var _author: String!
    private var _categories: String!
    private var _id: Int!
    private var _lastCheckedOut: String!
    private var _lastCheckedOutBy: String!
    private var _publisher: String!
    private var _title: String!
    private var _url: String!
    
    var author: String! {
        if _author == nil {
            _author = ""
        }
        return _author
    }
    
    var categories: String! {
        if _categories == nil{
            _categories = ""
        }
        return _categories
    }
    
    var id: Int! {
        if _id == nil{
            _id = -1
        }
        return _id
    }
    
    var lastCheckedOut: String! {
        if _lastCheckedOut == nil{
            _lastCheckedOut = ""
        }
        return _lastCheckedOut
    }
    
    var lastCheckedOutBy: String! {
        if _lastCheckedOutBy == nil{
            _lastCheckedOutBy = ""
        }
        return _lastCheckedOutBy
    }
    
    var publisher: String! {
        if _publisher == nil{
            _publisher = ""
        }
        return _publisher
    }
    
    var title: String! {
        if _title == nil{
            _title = ""
        }
        return _title
    }
    
    var url: String! {
        if _url == nil{
            _url = ""
        }
        return _url
    }
    
    init(_ bookDict: Dictionary<String, AnyObject>) {
        self._author = bookDict["author"] as! String
        self._categories = bookDict["categories"] as! String
        self._id = bookDict["id"] as! Int
        self._lastCheckedOut = bookDict["lastCheckedOut"] as! String
        self._lastCheckedOutBy = bookDict["lastCheckedOutBy"] as! String
        self._publisher = bookDict["publisher"] as! String
        self._title = bookDict["title "] as! String
        self._url = bookDict["url"] as! String
    }
    
}

