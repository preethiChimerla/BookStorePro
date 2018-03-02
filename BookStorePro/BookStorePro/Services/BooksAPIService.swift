//
//  BooksAPIService.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/1/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

import Foundation
import Alamofire

class BooksAPIService {
    private static var API_ENDPOINT = "http://prolific-interview.herokuapp.com/5a95a8a94ba45b000a4399df"
    private init() {}

    static func getAllBooks(completed: @escaping ([Book]?) -> Void) {
        var books: [Book] = []
        let getBooksEndpoint = URL(string: API_ENDPOINT + "/books")
        Alamofire.request(getBooksEndpoint!).responseJSON { (response) in
            guard response.result.isSuccess else {
                completed(nil)
                return
            }
            
            if let result = response.result.value as? [AnyObject] {
                for i in 0..<result.count {
                    let bookDict = result[i] as! Dictionary<String, AnyObject>
                    let book = Book(bookDict)
                    books.append(book)
                }
            }
            completed(books)
        }
    }

}


