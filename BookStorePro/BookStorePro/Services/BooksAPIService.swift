//
//  BooksAPIService.swift
//  BookStorePro
//
//  Created by preethi Reddy on 3/1/18.
//  Copyright © 2018 com.preethichimerla. All rights reserved.
//

/*
 @brief This is a service file which performs all the CRUD Operations on Books calling the API.
 Uses Alamofire networking library to interact with API
*/

import Foundation
import Alamofire

class BooksAPIService {
    private static let API_ENDPOINT = "http://prolific-interview.herokuapp.com/5a95a8a94ba45b000a4399df"
    private init() {}

    /*
        Performs a GET request on API to retrive all book and returns a completion handler with list of all books retrieved from the API, if unable to retrieve, returns nil.
        GET /books
     */
    static func getAllBooks(completed: @escaping ([Book]?) -> Void) {
        var books: [Book] = []
        let getBooksEndpoint = URL(string: API_ENDPOINT + "/books")!
        Alamofire.request(getBooksEndpoint).responseJSON { (response) in
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
    
    /*
     Performs a GET request on API to retrieve a book with Id (book URL) and returns a completion handler with retrived book, if unable to retrieve, returns nil.
     GET /books/<bookd_id>
     */
    static func getBookWithId(bookURL: String, completed: @escaping (Book?) -> Void) {
        let getBookEndpoint = URL(string: API_ENDPOINT + bookURL)!
        Alamofire.request(getBookEndpoint).responseJSON { (response) in
            guard response.result.isSuccess else {
                completed(nil)
                return
            }
            let book = Book(response.result.value as! Dictionary<String, AnyObject>)
            completed(book)
        }
    }
    
    /*
     Posts a new Book, on success, it returns true on success else false in completion handler.
     POST: /books
     */
    static func postNewBook(_ bookDict: Dictionary<String, String>, completed: @escaping (Bool) -> Void) {
        let postBooksEndpoint = URL(string: API_ENDPOINT + "/books")!
        Alamofire.request(postBooksEndpoint, method: .post, parameters: bookDict, encoding: JSONEncoding.default).responseJSON { (response) in
            guard response.result.isSuccess else {
                completed(false)
                return
            }
            completed(true)
        }
    }
    
    /*
     Deletes a Book with given Id, on success, it returns true on success else false in completion handler.
     DELETE: /books/<id>
     */
    static func deleteBook(bookId: Int, completed: @escaping (Bool) -> Void) {
        let deleteBookEndpoint = URL(string: API_ENDPOINT + "/books/\(bookId)")!
        Alamofire.request(deleteBookEndpoint, method: .delete).responseJSON { (response) in
            guard response.result.isSuccess else {
                completed(false)
                return
            }
            completed(true)
        }
    }
    
    /*
     Deletes all books, on success, it returns true on success else false in completion handler.
     DELETE: /clean
    */
    static func deleteAllBooks(completed: @escaping () -> Void) {
        let deleteAllBooksEndpoint = URL(string: API_ENDPOINT + "/clean")!
        Alamofire.request(deleteAllBooksEndpoint, method: .delete).responseJSON { (response) in
            completed()
        }
    }
    
    /*
     Put request to checkout a book, on success returns completion handler with updated details of book checked out, else returns nil
     PUT: /books/<id>
     */
    static func putCheckoutBook(_ checkoutForm: Dictionary<String, String>, bookId: Int, completed: @escaping (Book?) -> Void) {
        let checkoutBookEndpoint = URL(string: API_ENDPOINT + "/books/\(bookId)")!
        Alamofire.request(checkoutBookEndpoint, method: .put, parameters: checkoutForm, encoding: JSONEncoding.default).responseJSON { (response) in
            guard response.result.isSuccess else {
                completed(nil)
                return
            }
            let book = Book(response.result.value as! Dictionary<String, AnyObject>)
            completed(book)
        }
    }
    
}


