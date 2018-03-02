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
    private final var API_ENDPOINT = "http://prolific-interview.herokuapp.com/5a95a8a94ba45b000a4399df"
    private var _books: [Book] = []
    private init() {}
    
    var instance = BooksAPIService()
    
    var books: [Book]! {
        return _books
    }
    
    func getAllBooks() -> [Book] {
        let getBooksEndpoint = URL(string: API_ENDPOINT + "/books")
        Alamofire.request(getBooksEndpoint!).responseJSON { (response) in
            guard response.result.isSuccess else {
//                let booksErrorAlert = UIAlertController(title: "API failed to respond", message: "Unable to retrieve books. Please try again later.", preferredStyle: .alert)
//                self.present(booksErrorAlert, animated: true, completion: nil)
                return
            }
            if let result = response.result.value as? [AnyObject] {
                for i in 0..<result.count {
                    let bookDict = result[i] as! Dictionary<String, AnyObject>
                    let book = Book(bookDict)
                    self._books.append(book)
                }
            }
        }
        return _books
    }

}


